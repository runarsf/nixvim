{ config, lib, pkgs, ... }:

# https://vim.fandom.com/wiki/Highlight_unwanted_spaces

{
  options.modules.gremlins.enable = lib.mkEnableOption "gremlins";

  config = lib.mkIf config.modules.gremlins.enable {
    extraPlugins = [
      {
        plugin = (pkgs.vimUtils.buildVimPlugin rec {
          name = "vim-unicode-homoglyphs";
          src = pkgs.fetchFromGitHub {
            owner = "Konfekt";
            repo = name;
            rev = "c52e957edd1dcc679d221903b7e623ba15b155fb";
            hash = "sha256-zOQ1uAu3EJ8O+WSRtODGkC1WTlOOh13Dmkjg5IkkLqE=";
          };
        });
      }
      {
        plugin = (pkgs.vimUtils.buildVimPlugin rec {
          name = "vim-troll-stopper";
          src = pkgs.fetchFromGitHub {
            owner = "vim-utils";
            repo = name;
            rev = "24a9db129cd2e3aa2dcd79742b6cb82a53afef6c";
            hash = "sha256-5Fa/zK5f6CtRL+adQj8x41GnwmPWPV1+nCQta8djfqs=";
          };
        });
      }
    ];
  };
}
