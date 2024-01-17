{ lib, pkgs, ... }: {
  imports = [ ./options.nix ./autocommands.nix ./theme.nix ./plugins.nix ./keymaps.nix ];

  # TODO Formatting with nixfmt
  # TODO Properly package (python) dependencies

  extraPackages = with pkgs; [
    glow
    (python311.withPackages(ps: with ps; [
      jupyter-client
      cairosvg
      pnglatex
      plotly
      # kaleido
      pyperclip
      nbformat
    ]))
  ];

  extraConfigLuaPre =
    lib.concatStringsSep "\n" [ (builtins.readFile ./utils.lua) ];
}
