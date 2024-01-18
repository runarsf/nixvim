{ pkgs, ... }: {
  extraLuaPackages = with pkgs; [ magick ];
  extraPackages = with pkgs; [ imagemagick ];
  extraPython3Packages = p:
    with p; [
      pynvim
      jupyter-client
      jupyter-core
      cairosvg
      pnglatex
      plotly
      pyperclip
      nbformat
    ];
  plugins = {
    molten = {
      enable = true;
      imageProvider = "image.nvim";
    };
    image = {
      enable = true;
      package = pkgs.stable.vimPlugins.image-nvim;
    };
  };
}
