{ config, lib, ... }:

let
  mkSources = sources:
    map (source: if lib.isAttrs source then source else { name = source; })
    sources;

in {
  options.modules.cmp.enable = lib.mkEnableOption "cmp";

  config = lib.mkIf config.modules.cmp.enable {
    plugins = {
      copilot-chat = {
        enable = true;
        settings.window.border = "rounded";
      };
      copilot-cmp.enable = true;
      copilot-lua = {
        enable = true;
        suggestion.enabled = false;
        panel.enabled = false;
        filetypes = lib.true [ "*" "." ] // lib.false [
          "yaml"
          "markdown"
          "help"
          "gitcommit"
          "gitrebase"
          "hgcommit"
          "svn"
          "cvs"
        ];
      };

      luasnip = {
        enable = true;
        extraConfig = {
          enable_autosnippets = false;
          store_selection_keys = "<Tab>";
        };
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          window = {
            completion = {
              scrollbar = false;
              scrolloff = 2;
              border = "rounded";
              winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None";
            };
            documentation.maxHeight = "math.floor(vim.o.lines / 2)";
          };
          preselect = "None";
          snippet.expand =
            "function(args) require('luasnip').lsp_expand(args.body) end";
          matching.disallowPartialFuzzyMatching = false;
          sources = mkSources [
            "nvim_lsp"
            "treesitter"
            "fuzzy-path"
            "path"
            "buffer"
            "copilot"
          ];
          # TODO More consistent Tab binds
          # TODO Better smart indent https://www.reddit.com/r/neovim/comments/101kqds/comment/j2p5xe4
          # QUESTION Fix binds like the quickfix menu in vscode?
          mapping = {
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = "cmp.mapping.confirm({ select = false })";
            "<C-Space>" = ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.close()
                else
                  cmp.complete()
                end
              end, { "i", "n", "v" })
            '';
            "<Tab>" = ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_locally_jumpable()
                elseif HasWordsBefore() then
                  cmp.complete()
                else
                  ${
                    if config.plugins.intellitab.enable then
                      "vim.cmd[[silent! lua require('intellitab').indent()]]"
                    else
                      "fallback()"
                  }
                end
              end, { "i", "s" })
            '';
            "<S-Tab>" = ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end, { "i", "s" })
            '';
          };
        };
      };
    };
  };
}
