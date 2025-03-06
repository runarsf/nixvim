{
  config,
  lib,
  ...
}: {
  options.modules.http.enable = lib.mkEnableOption "http";

  config = lib.mkIf config.modules.http.enable {
    plugins.kulala = {
      enable = true;
      settings.display_mode = "float";
    };

    # keymaps = [
    #   {
    #     key = "F";
    #     action = "<CMD><CR>";
    #     options.desc = "Hop";
    #   }
    # ];
  };
}
