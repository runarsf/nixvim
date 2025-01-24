# NOTE Use this to update hashes: https://github.com/expipiplus1/update-nix-fetchgit

self: super: {
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/vim/plugins/build-vim-plugin.nix
  vimPlugins = super.vimPlugins // {
    vim-unicode-homoglyphs = super.vimUtils.buildVimPlugin rec {
      name = "vim-unicode-homoglyphs";
      src = super.fetchFromGitHub {
        owner = "Konfekt";
        repo = name;
        rev = "d772e23558abfa8b38a7ed1354f238b4d384644b";
        hash = "sha256-VDn3yVV6/Hkrhxpd1biSG/SxoqmHHvk778ApUiCcRRQ=";
      };
    };

    vim-troll-stopper = super.vimUtils.buildVimPlugin rec {
      name = "vim-troll-stopper";
      src = super.fetchFromGitHub {
        owner = "vim-utils";
        repo = name;
        rev = "24a9db129cd2e3aa2dcd79742b6cb82a53afef6c";
        hash = "sha256-5Fa/zK5f6CtRL+adQj8x41GnwmPWPV1+nCQta8djfqs=";
      };
    };

    vim-togglemouse = super.vimUtils.buildVimPlugin rec {
      name = "vim-togglemouse";
      src = super.fetchFromGitHub {
        owner = "nvie";
        repo = name;
        rev = "f157c757d6642b1829560c0db27f81ea5b4ee2f1";
        hash = "sha256-KCdTWqKFbYBKYmhWwA9YW1pjySZowLCsb2wjKUDPfeU=";
      };
    };

    inlay-hints = super.vimUtils.buildVimPlugin rec {
      name = "inlay-hints.nvim";
      src = super.fetchFromGitHub {
        owner = "MysticalDevil";
        repo = name;
        rev = "1d5bd49a43f8423bc56f5c95ebe8fe3f3b96ed58";
        hash = "sha256-E6+h9YIMRlot0umYchGYRr94bimBosunVyyvhmdwjIo=";
      };
    };

    search = super.vimUtils.buildVimPlugin rec {
      name = "search.nvim";
      src = super.fetchFromGitHub {
        owner = "FabianWirth";
        repo = name;
        rev = "7b8f2315d031be73e14bc2d82386dfac15952614";
        hash = "sha256-88rMEtHTk5jEQ00YleSr8x32Q3m0VFZdxSE2vQ+f0rM=";
      };
      doCheck = false;
    };

    pretty-fold = super.vimUtils.buildVimPlugin rec {
      name = "pretty-fold.nvim";
      src = super.fetchFromGitHub {
        owner = "bbjornstad";
        repo = name;
        rev = "1eb18f228972e86b7b8f5ef33ca8091e53fb1e49";
        hash = "sha256-0cHPm+JPGoYsjJEg3eIWv2Td1S+LQYBRbp71XPQsWMg=";
      };
    };

    typst-preview = super.vimUtils.buildVimPlugin rec {
      name = "typst-preview.nvim";
      src = super.fetchFromGitHub {
        owner = "chomosuke";
        repo = name;
        rev = "c1100e8788baabe8ca8f8cd7fd63d3d479e49e36";
        hash = "sha256-d6Tv7xZRghYYDfABk/p2e9qTm4qnWHM+ejKDCcR0TfY=";
      };
    };

    longlines = super.vimUtils.buildVimPlugin rec {
      name = "vim-longlines";
      src = super.fetchFromGitHub {
        owner = "manu-mannattil";
        repo = name;
        rev = "1750f070441c77e31e4cdeb7b35bf833133a5567";
        hash = "sha256-1gX1Johyq8rZbsURAyk2NZEmJwux1z5NGcFa1yehmCI=";
      };
    };

    duck = super.vimUtils.buildVimPlugin rec {
      name = "duck.nvim";
      src = super.fetchFromGitHub {
        owner = "tamton-aquib";
        repo = name;
        rev = "d8a6b08af440e5a0e2b3b357e2f78bb1883272cd";
        hash = "sha256-97QSkZHpHLq1XyLNhPz88i9VuWy6ux7ZFNJx/g44K2A=";
      };
    };

    nvchad-minty = super.vimUtils.buildVimPlugin rec {
      name = "minty";
      src = super.fetchFromGitHub {
        owner = "NvChad";
        repo = name;
        rev = "6dce9f097667862537823d515a0250ce58faab05";
        hash = "sha256-U6IxF/i1agIGzcePYg/k388GdemBtA7igBUMwyQ3d3I=";
      };
      doCheck = false;
    };

    nvchad-volt = super.vimUtils.buildVimPlugin rec {
      name = "volt";
      src = super.fetchFromGitHub {
        owner = "NvChad";
        repo = name;
        rev = "357b88862b60ef3a4154f4d25e3befe7c2f6b491";
        hash = "sha256-iDlUSk51GrKkYlO+tdqK3d4KWtj0YjGOGz5/c9Ci9Uc=";
      };
      doCheck = false;
    };

    nvchad-menu = super.vimUtils.buildVimPlugin rec {
      name = "menu";
      src = super.fetchFromGitHub {
        owner = "NvChad";
        repo = name;
        rev = "7769b17c2a131108c02b10e9f844e504aa605cc2";
        hash = "sha256-VEFUUo3h1Wg2+Yn7n83DZYoScKKLl6oIbmBt0WClAb0=";
      };
      doCheck = false;
    };
  };
}
