{
  description = "Personal Neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgsMaster.url = "github:nixos/nixpkgs/master";
    flakeUtils.url = "github:numtide/flake-utils";
    treefmtNix.url = "github:numtide/treefmt-nix";

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
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      flakeUtils,
      treefmtNix,
      nixlib,
      nixvim,
      ...
    }:
    flakeUtils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = map (f: import f { inherit inputs; }) (utils.umport { path = ./overlays; });
        };
        utils = import ./utils {
          inherit inputs system pkgs;
          inherit (nixpkgs) lib;
        };
        treefmtEval = treefmtNix.lib.evalModule pkgs ./treefmt.nix;
        config = {
          inherit pkgs;

          module = {
            imports = utils.umport {
              paths = [
                ./config
                ./modules
              ];
            };
          };

          extraSpecialArgs =
            let
              lib'' = nixpkgs.lib.extend (self: super: { inherit utils; });
              lib' = lib''.extend nixvim.lib.overlay;
              lib = lib'.extend (self: super: nixlib.lib.${system});
            in
            {
              inherit inputs lib;
            };
        };
      in
      {
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
