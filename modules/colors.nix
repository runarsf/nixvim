{ config, pkgs, lib, ... }:

{
  options.modules.colors.enable = lib.mkEnableOption "colors";

  config = lib.mkIf config.modules.colors.enable {
    plugins.nvim-colorizer.enable = true;

    plugins.ccc = {
      enable = true;
      settings = { highlighter.auto_enable = false; };
    };

    keymaps = [{
      key = "<leader>c";
      action = "<CMD>lua require('minty.huefy').open( { border = true } )<CR>";
      options.desc = "Color picker";
    }];

    extraPlugins = with pkgs; [
      {
        plugin = vimUtils.buildVimPlugin rec {
          name = "minty";
          src = fetchFromGitHub {
            owner = "NvChad";
            repo = name;
            rev = "8809b2c7c2edbeb3fa9c3b05bd2e89934d54f526";
            hash = "sha256-fow/jlV25tQFr2UFlWyjDPOt1GOZdRCSDkpe4axOlJ8=";
          };
        };
      }
      {
        plugin = vimUtils.buildVimPlugin rec {
          name = "volt";
          src = fetchFromGitHub {
            owner = "NvChad";
            repo = name;
            rev = "ce1e55d52d86e33f340a20b45701b434cc684c15";
            hash = "sha256-jqQQ6r/EhwYpY19uAtebVOSeTIYTpAUwvzzSTkZVzC4=";
          };
        };
      }
      {
        plugin = vimUtils.buildVimPlugin rec {
          name = "menu";
          src = fetchFromGitHub {
            owner = "NvChad";
            repo = name;
            rev = "205b3de60bbd1dfa73fd12b04530743cd0e70b22";
            hash = "sha256-e9QoyP+4Vu85b0iJu0scIn/32jbjLMDc99leVz7EdJs=";
          };
        };
      }
    ];
  };
}
