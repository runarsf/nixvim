{
  description = "Personal Neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nypkgs = {
      url = "github:yunfachi/nypkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

    nil_ls.url = "github:oxalica/nil";
  };

  outputs = inputs @ {
    nixpkgs,
    nixvim,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      utils = import ./utils.nix {
        inherit inputs system pkgs;
        lib = inputs.nixpkgs.lib;
      };
      nixpkgs-config = {
        allowUnfree = true;
        allowBroken = true;
      };
      overlays = [
        (final: _: {
          master = import inputs.nixpkgs-master {
            inherit system;
            config = nixpkgs-config;
          };
        })
        (import ./packages.nix)
      ];
      pkgs = import nixpkgs {
        inherit system overlays;
        config = nixpkgs-config;
      };
      nixvimLib = nixvim.lib.${system};
      nixvim' = nixvim.legacyPackages.${system};
      nixvimModule = {
        inherit pkgs;
        module = import ./config;
        extraSpecialArgs = {inherit inputs utils;};
      };
      nvim = nixvim'.makeNixvimWithModule nixvimModule;
    in {
      checks.default = nixvimLib.check.mkTestDerivationFromNvim nixvimModule;
      packages.default = nvim;
      formatter = pkgs.alejandra;
    });
}
