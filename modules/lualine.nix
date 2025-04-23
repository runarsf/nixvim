{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkModule config "lualine" {
  plugins.lualine = {
    enable = true;
    package = pkgs.master.vimPlugins.lualine-nvim;
    settings = {
      extensions = [
        "trouble"
        "toggleterm"
        "symbols-outline"
        "nvim-dap-ui"
      ];
      sections = {
        lualine_a = [
          {
            __unkeyed = "mode";
            padding = {
              left = 1;
              right = 0;
            };
            fmt =
              # lua
              ''
                function(mode)
                  local result = ""
                  for part in string.gmatch(mode, "[^-]+") do
                    if #part > 0 then
                      local first_char = string.upper(string.sub(part, 1, 1))
                      result = result .. first_char
                    end
                  end
                  return result
                end
              '';
          }
        ];
        lualine_b = [
          "branch"
          "diagnositcs"
          "diff"
        ];
        lualine_c = [
          "filename"
        ];
        lualine_x = [
          {
            __unkeyed = "lsp_status";
            # FIXME remove otter ls with a format function
            ignore_lsp = [
              "otter-ls"
              "copilot"
            ];
          }
          "StatusPaste()"
          "StatusMouse()"
          "encoding"
          "filetype"
        ];
        lualine_y = [
          "selectioncount"
          "searchcount"
        ];
      };
      options = {
        component_separators = {
          left = "";
          right = "";
        };
        section_separators = {
          left = "";
          right = "";
        };
      };
      component_separators = {
        left = "";
        right = "";
      };
      section_separators = {
        left = "";
        right = "";
      };
    };

    luaConfig.pre =
      # lua
      ''
        function StatusMouse()
          if #vim.o.mouse > 0 then return "M" else return "" end
        end
        function StatusPaste()
          if vim.o.paste then return "P" else return "" end
        end
        function Noop()
          return ""
        end
      '';
  };
}
