{
  config,
  lib,
  ...
}: {
  options.modules.lualine.enable = lib.mkEnableOption "lualine";

  config = lib.mkIf config.modules.lualine.enable {
    extraConfigLuaPre = ''
      function StatusMouse()
        if #vim.o.mouse > 0 then return "M" else return "" end
      end
      function StatusPaste()
        if vim.o.paste then return "P" else return "" end
      end
    '';

    plugins.lualine = {
      enable = true;
      settings = {
        extensions = ["trouble" "toggleterm" "symbols-outline" "nvim-dap-ui"];
        sections.lualine_x = ["StatusPaste()" "StatusMouse()" "encoding"];
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
    };
  };
}
