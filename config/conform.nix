{ pkgs, ... }: {
  keymaps = [{
    key = "<leader>f";
    action = "<CMD>w<CR><CMD>lua require'conform'.format()<CR>";
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
