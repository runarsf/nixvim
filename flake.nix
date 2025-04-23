{
  description = "Personal Neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixlib = {
      url = "git+ssh://git@github.com/runarsf/nixlib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nypkgs = {
      url = "github:yunfachi/nypkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix.url = "github:numtide/treefmt-nix";
    alejandra = {
      url = "github:kamadorueda/alejandra/4.0.0";
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
        lib = nixlib.lib.deepMerge [lib' nixlib.lib];
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
            ${nixpkgs.lib.getExe pkgs.update-nix-fetchgit} --verbose ./**/*.nix 2>&1 | grep --line-buffered -i "updating"
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
