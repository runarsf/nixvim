{
  description = "Personal Neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixlib = {
      url = "github:runarsf/nixlib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix.url = "github:numtide/treefmt-nix";

    dotfiles = {
      url = "github:runarsf/dotfiles";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-utils,
    treefmt-nix,
    nixlib,
    nixvim,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = map (f: import f {inherit inputs;}) (lib.concatPaths {paths = ./overlays;});
        };
        lib'' = nixpkgs.lib.extend (_: _: {inherit utils;});
        lib' = lib''.extend nixvim.lib.overlay;
        lib = nixlib.lib.deepMerge [
          lib'
          nixlib.lib
        ];
        utils = import ./utils {
          inherit
            inputs
            system
            pkgs
            lib
            ;
        };
        treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
        config = {
          inherit pkgs;

          module = {
            imports = lib.concatPaths {
              paths = [
                ./config
                ./modules
              ];
              filterDefault = false;
              exclude = [
                ./modules/dashboard/quotes.nix
              ];
            };
          };

          extraSpecialArgs = {
            inherit inputs lib;
          };
        };
      in {
        packages = rec {
          default = nixvim.legacyPackages.${system}.makeNixvimWithModule config;
          nvim = default;

          updater = pkgs.writeShellScriptBin "nixvim-flake-updater" ''
            printf '\033[1;34minfo:\033[0m updating fetchers...\n'
            ${nixpkgs.lib.getExe pkgs.update-nix-fetchgit} --verbose ./**/*.nix 2>&1 | grep --line-buffered -i "updating"
            printf '\033[1;34minfo:\033[0m updating flake inputs...\n'
            nix flake update
          '';
        };

        checks = {
          default = nixvim.lib.${system}.check.mkTestDerivationFromNvim config;
          formatting = treefmtEval.config.build.check self;
        };

        formatter = treefmtEval.config.build.wrapper;
      }
    );
}
