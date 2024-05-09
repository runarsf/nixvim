{ lib, ...}:

let
  layoutToString = layout: lib.strings.concatMapStringsSep ",\n" (s: "'${s}'") layout;

  generateLayout = rows: cols:
    let
      row = lib.concatStringsSep " " (lib.replicate cols "x");
    in
      lib.replicate rows row;

  createKeyboardCallback = name: layout: {
    __raw = ''
      function() require('qmk').setup({
        name = '${name}',
        comment_preview = { position = 'inside' },
        layout = {
          ${layoutToString layout}
        }
      }) end
    '';
  };

in {
  plugins.qmk = {
    enable = true;
    settings = {
      name = "LAYOUT_preonic_grid";
      layout = generateLayout 5 12;
    };
  };

  autoGroups.Qmk.clear = true;
  autoCmd = [
    {
      group = "Qmk";
      event = [ "BufEnter" ];
      pattern = [ "*preonic/keymap.c" ];
      callback = createKeyboardCallback "LAYOUT_preonic_grid" (generateLayout 5 12);
    }
    {
      group = "Qmk";
      event = [ "BufEnter" ];
      pattern = [ "*planck/keymap.c" ];
      callback = createKeyboardCallback "LAYOUT_planck_grid" (generateLayout 4 12);
    }
    {
      group = "Qmk";
      event = [ "BufEnter" ];
      pattern = [ "*framework/keymap.c" ];
      callback = createKeyboardCallback "LAYOUT_ortho_5x12" (generateLayout 5 12);
    }
    {
      group = "Qmk";
      event = [ "BufEnter" ];
      pattern = [ "*air40/keymap.c" ];
      callback = createKeyboardCallback "LAYOUT_ortho_4x12" (generateLayout 4 12);
    }
    {
      group = "Qmk";
      event = [ "BufEnter" ];
      pattern = [ "*lulu/keymap.c" ];
      callback = { __raw = "function() require('qmk').setup({
                    name = 'LAYOUT',
                    layout = {
                      'x x x x x x _ _ _ x x x x x x',
                      'x x x x x x _ _ _ x x x x x x',
                      'x x x x x x _ _ _ x x x x x x',
                      'x x x x x x x _ x x x x x x x',
                      '_ _ _ x x x x _ x x x x _ _ _'
                    }}) end"; };
    }
    { # Blank space layout, currently doesn't work
      group = "Qmk";
      event = [ "BufEnter" ];
      pattern = [ "*.keymap" ];
      callback = { __raw = "function() require('qmk').setup({
                    name = 'meh',
                    variant = 'zmk',
                    layout = {
                      ${layoutToString (generateLayout 4 12)}
                    }}) end"; };
    }
  ];
}
