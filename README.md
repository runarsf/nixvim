# Nixvim

For systems with [`nix`](https://nixos.org/download) installed

```nix
nix run github:runarsf/nixvim --extra-experimental-features 'nix-command flakes' -- hello.txt
```


## Using with NixOS / Home Manager

Add to flake inputs
```nix
inputs.nixvim.url = "github:runarsf/nixvim";
```

Create an overlay to replace default neovim
```nix
nixvim = final: prev: {
  neovim = inputs.nixvim.packages.${prev.system}.default;
};
```

Install neovim normally, system-wide or using home-manager. The overlay ensures the right package is installed.
```nix
home.packages = [ pkgs.neovim ];
environment.systemPackages = [ pkgs.neovim ];
```
