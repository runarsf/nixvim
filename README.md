# Nixvim

```nix
nix run github:runarsf/nixvim -- hello.txt
```

## Using with nixos / home-manager

```nix
# Add flake to inputs
inputs.nixvim.url = "github:runarsf/nixvim";

# Create an overlay to replace default neovim
nixvim = final: prev: {
  neovim = inputs.nixvim.packages.${prev.system}.default;
};

# Install neovim normally system wide or using home-manager
home.packages = [ pkgs.neovim ];
environment.systemPackages = [ pkgs.neovim ];
```
