{
  description = "Personal Neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flakeUtils.url = "github:numtide/flake-utils";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nypkgs = {
      url = "github:yunfachi/nypkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NOTE nil is locked while waiting for a release with pipe operator support
    nil_ls.url = "github:oxalica/nil/577d160da311cc7f5042038456a0713e9863d09e";
    nixfmt.url = "github:NixOS/nixfmt";
    nixd.url = "github:nix-community/nixd";
  };

  outputs = inputs @ {
    nixpkgs,
    flakeUtils,
    nixvim,
    ...
  }:
    flakeUtils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (import ./overlays/packages)
          (import ./overlays/vim-plugins.nix)
        ];
      };
      utils = import ./utils {
        inherit inputs system pkgs;
        inherit (nixpkgs) lib;
      };
      config = {
        inherit pkgs;

        module = {
          imports = utils.umport {paths = [./config ./modules];};
        };

        extraSpecialArgs = let
          lib' = nixpkgs.lib.extend (self: super: {inherit utils;});
          lib = lib'.extend nixvim.lib.overlay;
        in {
          inherit inputs lib;
        };
      };
    in {
      packages.default = nixvim.legacyPackages.${system}.makeNixvimWithModule config;

      checks.default = nixvim.lib.${system}.check.mkTestDerivationFromNvim config;

      formatter = pkgs.writeShellScriptBin "alejandra" ''
        exec ${pkgs.alejandra}/bin/alejandra --quiet "$@"
      '';
    });
}
