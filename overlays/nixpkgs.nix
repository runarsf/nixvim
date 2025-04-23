{inputs, ...}: _: super: {
  master = import inputs.nixpkgs-master {
    inherit (super) config overlays;
    inherit (super.stdenv.hostPlatform) system;
  };
  alejandra = inputs.alejandra.packages.${super.stdenv.hostPlatform.system}.default;
}
