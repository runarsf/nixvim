{
  plugins.nvim-cmp = {
    enable = true;
    autoEnableSources = true;
    sources = [
      { name = "calc"; }
      { name = "emoji"; }
      { name = "treesitter"; }
      { name = "nerdfont"; }
      { name = "luasnip"; }
      { name = "copilot.lua"; }
      { name = "git"; }
      { name = "fuzzy-path"; }
      { name = "nvim_lsp"; }
      { name = "path"; }
      { name = "buffer"; }
    ];

    mapping = {
      "<CR>" = "cmp.mapping.confirm({ select = true })";
      "<Tab>" = {
        action = ''
          function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expandable() then
              luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif check_backspace() then
              fallback()
            else
              fallback()
            end
          end
        '';
        modes = [ "i" "s" ];
      };
    };
  };
}
