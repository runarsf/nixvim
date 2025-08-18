{lib, ...}: {
  plugins = {
    # NOTE: DeferredUIEnter is the same as lazy.nvim's VeryLazy
    lz-n.enable = true;
    lzn-auto-require.enable = true;
  };
}
