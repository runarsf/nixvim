# Use this to update hashes: https://github.com/expipiplus1/update-nix-fetchgit
{ ... }:
self: super: {
  vimPlugins = super.vimPlugins // {
    jellybeans-nvim = super.vimUtils.buildVimPlugin {
      name = "jellybeans.nvim";
      src = super.fetchFromGitHub {
        owner = "WTFox";
        repo = "jellybeans.nvim";
        rev = "f82cb8e2e1134b38970e04f94cad1424ed39ab9f";
        hash = "sha256-+5dxANs9CakucLpD3uEy4B4j8hlxzYlASUeSzeB9N5M=";
      };
    };

    vim-unicode-homoglyphs = super.vimUtils.buildVimPlugin {
      name = "vim-unicode-homoglyphs";
      src = super.fetchFromGitHub {
        owner = "Konfekt";
        repo = "vim-unicode-homoglyphs";
        rev = "d772e23558abfa8b38a7ed1354f238b4d384644b";
        hash = "sha256-VDn3yVV6/Hkrhxpd1biSG/SxoqmHHvk778ApUiCcRRQ=";
      };
    };

    vim-troll-stopper = super.vimUtils.buildVimPlugin {
      name = "vim-troll-stopper";
      src = super.fetchFromGitHub {
        owner = "vim-utils";
        repo = "vim-troll-stopper";
        rev = "24a9db129cd2e3aa2dcd79742b6cb82a53afef6c";
        hash = "sha256-5Fa/zK5f6CtRL+adQj8x41GnwmPWPV1+nCQta8djfqs=";
      };
    };

    indentmini = super.vimUtils.buildVimPlugin {
      name = "indentmini.nvim";
      src = super.fetchFromGitHub {
        owner = "nvimdev";
        repo = "indentmini.nvim";
        rev = "59c2be5387e3a3308bb43f07e7e39fde0628bd4d";
        sha256 = "1a2bakxvsdz1qn0sp5y8kd3xkczhxbag1jph2n44r57ghaa4zls6";
      };
      doCheck = false;
    };

    vim-togglemouse = super.vimUtils.buildVimPlugin {
      name = "vim-togglemouse";
      src = super.fetchFromGitHub {
        owner = "nvie";
        repo = "vim-togglemouse";
        rev = "f157c757d6642b1829560c0db27f81ea5b4ee2f1";
        hash = "sha256-KCdTWqKFbYBKYmhWwA9YW1pjySZowLCsb2wjKUDPfeU=";
      };
    };

    inlay-hints = super.vimUtils.buildVimPlugin {
      name = "inlay-hints.nvim";
      src = super.fetchFromGitHub {
        owner = "MysticalDevil";
        repo = "inlay-hints.nvim";
        rev = "1d5bd49a43f8423bc56f5c95ebe8fe3f3b96ed58";
        hash = "sha256-E6+h9YIMRlot0umYchGYRr94bimBosunVyyvhmdwjIo=";
      };
    };

    search = super.vimUtils.buildVimPlugin {
      name = "search.nvim";
      src = super.fetchFromGitHub {
        owner = "FabianWirth";
        repo = "search.nvim";
        rev = "7b8f2315d031be73e14bc2d82386dfac15952614";
        hash = "sha256-88rMEtHTk5jEQ00YleSr8x32Q3m0VFZdxSE2vQ+f0rM=";
      };
      doCheck = false;
    };

    pretty-fold = super.vimUtils.buildVimPlugin {
      name = "pretty-fold.nvim";
      src = super.fetchFromGitHub {
        owner = "bbjornstad";
        repo = "pretty-fold.nvim";
        rev = "1eb18f228972e86b7b8f5ef33ca8091e53fb1e49";
        hash = "sha256-0cHPm+JPGoYsjJEg3eIWv2Td1S+LQYBRbp71XPQsWMg=";
      };
    };

    visual-nvim = super.vimUtils.buildVimPlugin {
      name = "visual.nvim";
      src = super.fetchFromGitHub {
        owner = "00sapo";
        repo = "visual.nvim";
        rev = "5eeb220b86cac7ff7041daf565ccf45f296bd107";
        hash = "sha256-tcqNMrUwYjFJq4/JEKXCA/NRAnU0B9oYeh6KC6MhnQM=";
      };
    };

    kak-nvim = super.vimUtils.buildVimPlugin {
      name = "kak.nvim";
      src = super.fetchFromGitHub {
        owner = "mirlge";
        repo = "kak.nvim";
        rev = "d4d55034232209d1476902ea004c48e01e06aa2a";
        hash = "sha256-KkF6eh3LMOTDE87x/YB3E8pCNAptxgRkJ2v2e19gGEU=";
      };
      doCheck = false;
    };

    typst-preview = super.vimUtils.buildVimPlugin {
      name = "typst-preview.nvim";
      src = super.fetchFromGitHub {
        owner = "chomosuke";
        repo = "typst-preview.nvim";
        rev = "c1100e8788baabe8ca8f8cd7fd63d3d479e49e36";
        hash = "sha256-d6Tv7xZRghYYDfABk/p2e9qTm4qnWHM+ejKDCcR0TfY=";
      };
    };

    longlines = super.vimUtils.buildVimPlugin {
      name = "vim-longlines";
      src = super.fetchFromGitHub {
        owner = "manu-mannattil";
        repo = "vim-longlines";
        rev = "1750f070441c77e31e4cdeb7b35bf833133a5567";
        hash = "sha256-1gX1Johyq8rZbsURAyk2NZEmJwux1z5NGcFa1yehmCI=";
      };
    };

    duck = super.vimUtils.buildVimPlugin {
      name = "duck.nvim";
      src = super.fetchFromGitHub {
        owner = "tamton-aquib";
        repo = "duck.nvim";
        rev = "d8a6b08af440e5a0e2b3b357e2f78bb1883272cd";
        hash = "sha256-97QSkZHpHLq1XyLNhPz88i9VuWy6ux7ZFNJx/g44K2A=";
      };
    };

    namu-nvim = super.vimUtils.buildVimPlugin {
      name = "namu.nvim";
      src = super.fetchFromGitHub {
        owner = "bassamsdata";
        repo = "namu.nvim";
        rev = "cb7b7e5975e694212460732453fa4f3245870886";
        hash = "sha256-xd7LmtLHURIX+lNk70G3FvOFCRf/uGONh6M5gigcbX4=";
      };
    };

    sequoia-moonlight-nvim = super.vimUtils.buildVimPlugin {
      name = "sequoia-moonlight.nvim";
      src = super.fetchFromGitHub {
        owner = "Hiroya-W";
        repo = "sequoia-moonlight.nvim";
        rev = "189ed14c7a5e3fbc8c6ba4a8b374f092de5181e4";
        hash = "sha256-W9mCBnmc4Fk7l2PK0kT4mCeXnPXdjLKp2uTpuLTdUJE=";
      };
    };

    nvchad-minty = super.vimUtils.buildVimPlugin {
      name = "minty";
      src = super.fetchFromGitHub {
        owner = "NvChad";
        repo = "minty";
        rev = "6dce9f097667862537823d515a0250ce58faab05";
        hash = "sha256-U6IxF/i1agIGzcePYg/k388GdemBtA7igBUMwyQ3d3I=";
      };
      doCheck = false;
    };

    nvchad-volt = super.vimUtils.buildVimPlugin {
      name = "volt";
      src = super.fetchFromGitHub {
        owner = "NvChad";
        repo = "volt";
        rev = "357b88862b60ef3a4154f4d25e3befe7c2f6b491";
        hash = "sha256-iDlUSk51GrKkYlO+tdqK3d4KWtj0YjGOGz5/c9Ci9Uc=";
      };
      doCheck = false;
    };

    nvchad-menu = super.vimUtils.buildVimPlugin {
      name = "menu";
      src = super.fetchFromGitHub {
        owner = "NvChad";
        repo = "menu";
        rev = "7769b17c2a131108c02b10e9f844e504aa605cc2";
        hash = "sha256-VEFUUo3h1Wg2+Yn7n83DZYoScKKLl6oIbmBt0WClAb0=";
      };
      doCheck = false;
    };
  };
}
