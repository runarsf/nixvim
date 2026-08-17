{
  lib,
  pkgs,
  ...
}: {
  globals = {
    mapleader = ",";
    maplocalleader = " ";
  };

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "D" ''"_d'' "Delete without yanking")
    (mkKeymap' "DD" ''"_dd'' "Delete line without yanking")
    (mkKeymap' "X" ''"_x'' "Delete under without yanking")
    (mkKeymap' "<Leader>s" ":%!sort<CR>" "Sort lines")
    (mkKeymap' "<Leader>I" "<CMD>Sleuth<CR>" "Re-guess indentation")
    (mkKeymap' "<Leader><Space>" "<CMD>nohlsearch<CR>" "Unhighlight matches")
  ];

  # TODO Move to keymapsOnEvents once it supports an event pattern
  #  Waiting for: https://github.com/nix-community/nixvim/issues/2359
  #  Information: https://github.com/expipiplus1/update-nix-fetchgit?tab=readme-ov-file#from-vim
  autoCmd = [
    {
      event = ["FileType"];
      pattern = ["nix"];
      callback = lib.nixvim.mkRaw ''
        function(event)
          vim.keymap.set("n", "<Leader>U", function()
            local view = vim.fn.winsaveview()
            vim.cmd("%!${lib.getExe pkgs.update-nix-fetchgit} --location=" .. vim.fn.line(".") .. ":" .. vim.fn.col("."))
            vim.fn.winrestview(view)
          end, { buffer = event.buf, nowait = true, desc = "Update fetcher under cursor" })
        end
      '';
    }
  ];
}
