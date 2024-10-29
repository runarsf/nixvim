{ config, lib, ... }:

{
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
        theme = "ayu_dark";
        component_separators.left = "";
        component_separators.right = "";
        section_separators.left = "";
        section_separators.right = "";
        extensions = [ "trouble" "toggleterm" "symbols-outline" ];
        sections.lualine_x = [ "StatusPaste()" "StatusMouse()" "encoding" ];
      };
    };
  };
}
