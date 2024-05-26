{ pkgs, ... }:

{
  keymaps = [
    {
      key = "<leader>ph";
      action = "<CMD>lua require('duck').hatch('🦆', 7)<CR>";
      options.desc = "Hatch duck";
    }
    {
      key = "<leader>pk";
      action = "<CMD>lua require('duck').cook_all()<CR>";
      options.desc = "Kill duck";
    }
  ];

  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin rec {
        name = "duck.nvim";
        src = pkgs.fetchFromGitHub {
            owner = "tamton-aquib";
            repo = name;
            rev = "0ca969d549f5d546ae395e163130024b51694235";
            hash = "sha256-meATA9jsIrRUAZ+5PkznR8RADAC3KbmTHaG4p0oietw=";
        };
    })
  ];
}
