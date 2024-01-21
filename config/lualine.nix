{
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
    theme = "ayu_dark";
    componentSeparators.left = "";
    componentSeparators.right = "";
    sectionSeparators.left = "";
    sectionSeparators.right = "";
    extensions = [
      "trouble"
      "toggleterm"
      "symbols-outline"
    ];
    sections.lualine_x = [
      "StatusPaste()"
      "StatusMouse()"
      "encoding"
    ];
  };
}
