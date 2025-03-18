{
  config,
  lib,
  pkgs,
  helpers,
  ...
}: let
  mkSources = sources:
    map (source:
      if lib.isAttrs source
      then source
      else {
        name = source;
        group_index = 2;
      })
    sources;
in {
  # TODO Limit width and line count of completions and documentation
  # TODO Add border to docs
  # TODO Better smart indent https://www.reddit.com/r/neovim/comments/101kqds/comment/j2p5xe4
  options.modules.cmp.enable = lib.mkEnableOption "cmp";

  config = lib.mkIf config.modules.cmp.enable {
    plugins = {
      cmp = {
        enable = true;
        autoEnableSources = true;
        cmdline = {
          "/" = {
            mapping = helpers.mkRaw "cmp.mapping.preset.cmdline()";
            sources = mkSources [
              "buffer"
              "cmdline_history"
              "nvim_lsp_document_symbol"
            ];
          };
          ":" = {
            mapping = helpers.mkRaw "cmp.mapping.preset.cmdline()";
            sources = mkSources ["path" "cmdline" "cmdline_history"];
          };
          "?" = {
            mapping = helpers.mkRaw "cmp.mapping.preset.cmdline()";
            sources = mkSources ["cmdline_history"];
          };
        };
        filetype = let
          mkFiletypeSettings = names: val:
            builtins.listToAttrs (lib.map (name: {
                name = name;
                value = val;
              })
              names);
        in
          mkFiletypeSettings ["dap-repl" "dapui_watches" "dapui_hover"] {
            sources = mkSources ["dap"];
          };
        settings = {
          formatting = {
            fields = ["kind" "abbr" "menu"];
            format = ''
              function(entry, vim_item)
                local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
                local strings = vim.split(kind.kind, "%s", { trimempty = true })
                kind.kind = " " .. (strings[1] or "") .. " "
                kind.menu = "    " .. (strings[2] or "")

                return kind
              end
            '';
          };
          preselect = "cmp.PreselectMode.None";
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
          window = {
            completion = {
              scrollbar = false;
              scrolloff = 2;
              border = "rounded";
              winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None";
              # winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None";
              col_offset = -4;
              side_padding = 0;
            };
            documentation = {
              border = "rounded";
              maxHeight = "math.floor(vim.o.lines / 2)";
            };
          };
          matching.disallowPartialFuzzyMatching = false;
          sources = mkSources [
            "nvim_lsp"
            "async_path"
            "buffer"
            "calc"
            "digraphs"
            "emoji"
            "greek"
            "nvim_lsp_signature_help"
            "treesitter"
            "luasnip"
            "copilot"
            {
              name = "rg";
              keyword_length = 3;
            }
          ];
          mapping = {
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = ''
              cmp.mapping({
                i = function(fallback)
                  if cmp.visible() and cmp.get_active_entry() then
                    if luasnip.expandable() then
                      luasnip.expand()
                    else
                      cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                    end
                  else
                    fallback()
                  end
                end,
                s = cmp.mapping.confirm({ select = false }),
                c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
              })
            '';
            "<Tab>" = ''
              cmp.mapping(function(fallback)
                local luasnip = require("luasnip")

                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.locally_jumpable(1) then
                  luasnip.jump(1)
                elseif not cmp.select_next_item() and HasWordsBefore() and vim.bo.buftype ~= 'prompt' then
                  cmp.complete()
                else
                  ${
                if config.plugins.intellitab.enable
                then "vim.cmd[[silent! lua require('intellitab').indent()]]"
                else "fallback()"
              }
                end
              end, { "i", "s" })
            '';
            "<S-Tab>" = ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif luasnip.locally_jumpable(-1) then
                  luasnip.jump(-1)
                elseif not cmp.select_next_item() and HasWordsBefore() and vim.bo.buftype ~= 'prompt' then
                  cmp.complete()
                else
                  fallback()
                end
              end, { "i", "s" })
            '';
            "<C-Space>" = ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.close()
                else
                  cmp.complete()
                end
              end, { "i", "n", "v" })
            '';
          };
        };
      };

      luasnip.enable = true;
      copilot-chat = {
        enable = true;
        settings.window.border = "rounded";
      };
    };

    extraPlugins = with pkgs.vimPlugins; [lspkind-nvim];

    # highlightOverride = {
    #   PmenuSel = {
    #     bg = "#282C34";
    #     fg = "NONE";
    #   };
    #   Pmenu = {
    #     fg = "#C5CDD9";
    #     bg = "#22252A";
    #   };
    #   CmpItemAbbrDeprecated = {
    #     fg = "#7E8294";
    #     bg = "NONE";
    #     strikethrough = true;
    #   };
    #   CmpItemAbbrMatch = {
    #     fg = "#82AAFF";
    #     bg = "NONE";
    #     bold = true;
    #   };
    #   CmpItemAbbrMatchFuzzy = {
    #     fg = "#82AAFF";
    #     bg = "NONE";
    #     bold = true;
    #   };
    #   CmpItemMenu = {
    #     fg = "#C792EA";
    #     bg = "NONE";
    #     italic = true;
    #   };
    #   CmpItemKindField = {
    #     fg = "#EED8DA";
    #     bg = "#B5585F";
    #   };
    #   CmpItemKindProperty = {
    #     fg = "#EED8DA";
    #     bg = "#B5585F";
    #   };
    #   CmpItemKindEvent = {
    #     fg = "#EED8DA";
    #     bg = "#B5585F";
    #   };
    #   CmpItemKindText = {
    #     fg = "#C3E88D";
    #     bg = "#9FBD73";
    #   };
    #   CmpItemKindEnum = {
    #     fg = "#C3E88D";
    #     bg = "#9FBD73";
    #   };
    #   CmpItemKindKeyword = {
    #     fg = "#C3E88D";
    #     bg = "#9FBD73";
    #   };
    #   CmpItemKindConstant = {
    #     fg = "#FFE082";
    #     bg = "#D4BB6C";
    #   };
    #   CmpItemKindConstructor = {
    #     fg = "#FFE082";
    #     bg = "#D4BB6C";
    #   };
    #   CmpItemKindReference = {
    #     fg = "#FFE082";
    #     bg = "#D4BB6C";
    #   };
    #   CmpItemKindFunction = {
    #     fg = "#EADFF0";
    #     bg = "#A377BF";
    #   };
    #   CmpItemKindStruct = {
    #     fg = "#EADFF0";
    #     bg = "#A377BF";
    #   };
    #   CmpItemKindClass = {
    #     fg = "#EADFF0";
    #     bg = "#A377BF";
    #   };
    #   CmpItemKindModule = {
    #     fg = "#EADFF0";
    #     bg = "#A377BF";
    #   };
    #   CmpItemKindOperator = {
    #     fg = "#EADFF0";
    #     bg = "#A377BF";
    #   };
    #   CmpItemKindVariable = {
    #     fg = "#C5CDD9";
    #     bg = "#7E8294";
    #   };
    #   CmpItemKindFile = {
    #     fg = "#C5CDD9";
    #     bg = "#7E8294";
    #   };
    #   CmpItemKindUnit = {
    #     fg = "#F5EBD9";
    #     bg = "#D4A959";
    #   };
    #   CmpItemKindSnippet = {
    #     fg = "#F5EBD9";
    #     bg = "#D4A959";
    #   };
    #   CmpItemKindFolder = {
    #     fg = "#F5EBD9";
    #     bg = "#D4A959";
    #   };
    #   CmpItemKindMethod = {
    #     fg = "#DDE5F5";
    #     bg = "#6C8ED4";
    #   };
    #   CmpItemKindValue = {
    #     fg = "#DDE5F5";
    #     bg = "#6C8ED4";
    #   };
    #   CmpItemKindEnumMember = {
    #     fg = "#DDE5F5";
    #     bg = "#6C8ED4";
    #   };
    #   CmpItemKindInterface = {
    #     fg = "#D8EEEB";
    #     bg = "#58B5A8";
    #   };
    #   CmpItemKindColor = {
    #     fg = "#D8EEEB";
    #     bg = "#58B5A8";
    #   };
    #   CmpItemKindTypeParameter = {
    #     fg = "#D8EEEB";
    #     bg = "#58B5A8";
    #   };
    # };
  };
}
