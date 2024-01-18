{ pkgs, ... }: {
  # NOTE To install a kernel, run:
  #  $ python -m ipykernel install --user --name jupyter
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
      jupytext
      ipykernel
    ];
  plugins = {
    molten = {
      enable = true;
      imageProvider = "image.nvim";
    };
    image = {
      enable = true;
      # Unstable release is broken :⁾
      package = pkgs.stable.vimPlugins.image-nvim;
    };
  };
}
