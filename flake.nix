{
  description = "Personal Neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    utils.url = "github:numtide/flake-utils";
    nypkgs = {
      url = "github:yunfachi/nypkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, nixvim, utils, ... }:
    utils.lib.eachDefaultSystem (system:
      let
        lib = import ./lib.nix { inherit inputs system; };
        overlays = [
          (final: _: {
            master = import inputs.nixpkgs-master {
              system = final.system;
              config = {
                allowUnfree = true;
                allowBroken = true;
              };
            };
          })
        ];
        pkgs = import nixpkgs { inherit system overlays; };
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
