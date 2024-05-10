{ config, ... }:

{
  plugins = {
    copilot-cmp.enable = true;
    copilot-lua = {
      enable = true;
      suggestion.enabled = false;
      panel.enabled = false;
      filetypes = {
        yaml = false;
        markdown = false;
        help = false;
        gitcommit = false;
        gitrebase = false;
        hgcommit = false;
        svn = false;
        cvs = false;
        "*" = true;
        "." = true;
      };
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
        snippet.expand = "luasnip";
        matching.disallowPartialFuzzyMatching = false;
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "calc"; }
          { name = "emoji"; }
          { name = "treesitter"; }
          { name = "nerdfont"; }
          { name = "git"; }
          { name = "fuzzy-path"; }
          { name = "path"; }
          { name = "buffer"; }
          { name = "copilot"; }
        ];
        mapping = {
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-e>" = "cmp.mapping.close()";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<CR>" = ''
            cmp.mapping({
              i = function(fallback)
                if cmp.visible() and cmp.get_active_entry() then
                  cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                else
                  fallback()
                end
              end,
              s = cmp.mapping.confirm({ select = true }),
              c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
            })
          '';
          "<C-Space>" = ''
            cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.close()
              else
                cmp.complete()
              end
            end)
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
                ${if config.plugins.intellitab.enable then
                  "require('intellitab').indent()"
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
            end, { "i", "s", "c" })
          '';
        };
      };
    };
  };
}
