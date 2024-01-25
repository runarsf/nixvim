{ pkgs, ... }:

{
  keymaps = [
    {
      key = "<leader>Mi";
      action = "<CMD>MoltenInit<CR>";
    }
    {
      key = "<leader>Ml";
      action = "<CMD>MoltenEvaluateLine<CR>";
    }
    {
      key = "<leader>Mv";
      action = "<CMD>MoltenEvaluateVisual<CR>gv";
    }
    {
      key = "<leader>Md";
      action = "<CMD>MoltenDelete<CR>";
    }
    {
      key = "<leader>MI";
      action = "<CMD>MoltenInfo<CR>";
    }
    {
      key = "<leader>Mr";
      action = "<CMD>MoltenReevaluateCell<CR>";
    }
    {
      key = "<leader>Me";
      action = "<CMD>MoltenEvaluateOperator<CR>";
    }
  ];

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
      package = pkgs.stable.vimPlugins.image-nvim;
    };
  };
}
