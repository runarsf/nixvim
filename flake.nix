{
  description = "Personal Neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
    nypkgs = {
      url = "github:yunfachi/nypkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, nixvim, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        # lib = import ./lib.nix { inherit inputs system; };
        utils = import ./utils.nix {
          inherit inputs system;
          lib = inputs.nixpkgs.lib;
        };
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
        nixvimModule = {
          inherit pkgs;
          module = import ./config;
          extraSpecialArgs = { inherit inputs utils; };
        };
        nvim = nixvim'.makeNixvimWithModule nixvimModule;
      in {
        checks.default = nixvimLib.check.mkTestDerivationFromNvim nixvimModule;
        packages.default = nvim;
        formatter = pkgs.nixfmt;
      });
}
