_:

{
  keymaps = [
    {
      key = "<leader>f";
      action = "<CMD>lua require'conform'.format()<CR>";
      options.desc = "Format active file";
    }
    {
      key = "<leader>F";
      action = "<CMD>w | sleep 200m | lua require'conform'.format()<CR>";
      options.desc = "Write and format active file";
    }
  ];

  plugins.conform-nvim = {
    enable = true;
    # formatters = {
    #   nixfmt = {
    #     command = "${pkgs.nixfmt}/bin/nixfmt";
    #     args = [ "$FILENAME" ];
    #   };
    #   dart_format = {
    #     command = "${pkgs.dart}/bin/dart";
    #     args = [ "format" "$FILENAME" ];
    #   };
    # };
    formattersByFt = {
      nix = [ "nixfmt" ];
      dart = [ "dart_format" ];
      lua = [ "stylua" ];
      c = [ "clang-format" ];
      cpp = [ "clang-format" ];
      python = [ "isort" "ruff_fix" "ruff_format" ];
      javascript = [[ "prettierd" "prettier" ]];
      typescript = [[ "prettierd" "prettier" ]];
      typst = [ "typstfmt" ];
      cs = [[ "uncrustify" "csharpier" ]];
    };
  };
}
