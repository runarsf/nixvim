{ pkgs, ... }:

{
  keymaps = [{
    key = "<leader>f";
    action = "<CMD>w | sleep 200m | lua require'conform'.format()<CR>";
  }];

  plugins.conform-nvim = {
    enable = true;
    formatters = {
      nixfmt = {
        command = "${pkgs.nixfmt}/bin/nixfmt";
        args = [ "$FILENAME" ];
      };
    };
    formattersByFt = { nix = [ "nixfmt" ]; };
  };
}
