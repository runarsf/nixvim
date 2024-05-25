{
  description = "Personal Neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, nixvim, utils, ... }:
    utils.lib.eachDefaultSystem (system:
      let
        lib = import ./lib.nix {
          inherit inputs system;
        };
        pkgs = import nixpkgs { inherit system; };
        nixvimLib = nixvim.lib.${system};
        nixvim' = nixvim.legacyPackages.${system};
        nvim = nixvim'.makeNixvimWithModule {
          inherit pkgs;
          module = import ./config;
          extraSpecialArgs = { inherit inputs lib; };
        };
      in {
        checks.default = nixvimLib.check.mkTestDerivationFromNvim {
          inherit nvim lib;
          name = "Personal Neovim configuration";
        };
        packages.default = nvim;
        formatter = pkgs.nixfmt;
      });
}
