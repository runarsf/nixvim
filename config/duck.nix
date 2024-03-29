{ pkgs, ... }:

{
  keymaps = [
    {
      key = "<leader>pd";
      action = "<CMD>lua require('duck').hatch('🦆', 7)<CR>";
    }
    {
      key = "<leader>pk";
      action = "<CMD>lua require('duck').cook_all()<CR>";
    }
  ];

  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
        name = "duck.nvim";
        src = pkgs.fetchFromGitHub {
            owner = "tamton-aquib";
            repo = "duck.nvim";
            rev = "0ca969d549f5d546ae395e163130024b51694235";
            hash = "sha256-meATA9jsIrRUAZ+5PkznR8RADAC3KbmTHaG4p0oietw=";
        };
    })
  ];
}
