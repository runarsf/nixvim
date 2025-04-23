{
  config,
  lib,
  ...
}:
lib.mkModule config "lsp" {
  plugins.lsp = {
    enable = true;
    inlayHints = true;
  };

  keymaps = [
    {
      key = "<C-.>";
      action = "<CMD>lua vim.lsp.buf.code_action()<CR>";
      mode = [
        "i"
        "n"
      ];
      options.desc = "(lsp) Code actions";
    }
    {
      key = "<C-.>";
      action = "<CMD>lua vim.lsp.buf.range_code_action()<CR>";
      mode = ["x"];
      options.desc = "(lsp) Code actions";
    }
    {
      key = "gd";
      action = "<CMD>lua vim.lsp.buf.definition()<CR>";
      mode = ["n"];
      options.desc = "(lsp) Go to definition";
    }
    {
      key = "gD";
      action = "<CMD>lua vim.lsp.buf.declaration()<CR>";
      mode = ["n"];
      options.desc = "(lsp) Go to declaration";
    }
    {
      key = "gr";
      action = "<CMD>lua vim.lsp.buf.references()<CR>";
      mode = ["n"];
      options.desc = "(lsp) Go to references";
    }
    {
      key = "K";
      action = "<CMD>lua vim.lsp.buf.hover()<CR>";
      mode = ["n"];
      options.desc = "(lsp) Hover";
    }
    {
      key = "<Leader>R";
      action = "<CMD>lua vim.lsp.buf.rename()<CR>";
      mode = ["n"];
      options.desc = "(lsp) Rename";
    }
    {
      key = "<Leader>h";
      action = "<CMD>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>";
      options.desc = "(lsp) Toggle inlay hints";
    }
  ];
}
