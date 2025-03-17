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

    # NOTE nil is locked while waiting for a release with pipe operator support
    nil_ls.url = "github:oxalica/nil/577d160da311cc7f5042038456a0713e9863d09e";
    nixfmt.url = "github:NixOS/nixfmt";
    nixd.url = "github:nix-community/nixd";
  };

  outputs = inputs @ {
    nixpkgs,
    nixvim,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs rec {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (_: _: {
            master = import inputs.nixpkgs-master {
              inherit system config;
            };
          })
          (import ./packages.nix)
        ];
      };
      utils = import ./utils.nix {
        inherit inputs system pkgs;
        inherit (nixpkgs) lib;
      };
      nixvimModule = {
        inherit pkgs;
        module = import ./config;
        extraSpecialArgs = {inherit inputs utils;};
      };
    in {
      packages.default = nixvim.legacyPackages.${system}.makeNixvimWithModule nixvimModule;

      checks.default = nixvim.lib.${system}.check.mkTestDerivationFromNvim nixvimModule;

      formatter = pkgs.alejandra;
    });
}
