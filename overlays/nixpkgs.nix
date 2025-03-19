{inputs, ...}: self: super: {
  master = import inputs.nixpkgsMaster {
    inherit (super) system config overlays;
  };
}
