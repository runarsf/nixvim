{
  config,
  lib,
  ...
}:
lib.mkModule config "hop" {
  plugins.hop = {
    enable = true;
    settings.keys = "etovxqpdygfblzhckisuran";
  };

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "f" "<CMD>HopPattern<CR>" "Hop (pattern)")
    (mkKeymap' "F" "<CMD>HopAnywhere<CR>" "Hop")
  ];
}
