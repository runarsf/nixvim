{ config, ... }:

{
  plugins = {
    copilot-cmp.enable = true;
    copilot-lua = {
      enable = true;
      suggestion.enabled = false;
      panel.enabled = false;
    };

    luasnip = {
      enable = true;
      extraConfig = {
        enable_autosnippets = false;
        store_selection_keys = "<Tab>";
      };
    };

    nvim-cmp = {
      enable = true;
      autoEnableSources = true;
      preselect = "None";
      matching.disallowPartialFuzzyMatching = false;
      snippet.expand = "luasnip";
      window = {
        completion = {
          scrollbar = false;
          scrolloff = 2;
          border = "rounded";
          winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None";
        };
        documentation.maxHeight = "math.floor(vim.o.lines / 2)";
      };
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
        { name = "copilot.lua"; }
        { name = "dap"; }
      ];
      mapping = {
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        "<C-e>" = "cmp.mapping.close()";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<CR>" = {
          action = ''
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
        };
        "<C-Space>" = {
          action = ''
            cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.close()
              else
                cmp.complete()
              end
            end)
          '';
        };
        "<Tab>" = {
          action = ''
            cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_locally_jumpable()
              elseif HasWordsBefore() then
                cmp.complete()
              else
                ${if config.plugins.intellitab.enable then
                  "vim.cmd[[silent! lua require('intellitab').indent()]]"
                else
                  "fallback()"
                }
              end
            end, { "i", "s" })
          '';
        };
        "<S-Tab>" = {
          action = ''
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
}
