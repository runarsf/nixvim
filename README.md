# Nixvim

For systems with [`nix`](https://nixos.org/download) installed, the configuration can be tested with
```nix
nix run github:runarsf/nixvim --extra-experimental-features 'nix-command flakes' -- flake.nix
```

Alternatively, it can be tested using docker
```nix
docker run -it ghcr.io/nixos/nix nix run github:runarsf/nixvim --extra-experimental-features 'nix-command flakes' -- flake.nix
```

You can also run it locally
```nix
nix run . -- flake.nix
```


## Using with NixOS / Home Manager

Add to flake inputs
```nix
inputs.nixvim.url = "github:runarsf/nixvim";
```

Create an overlay to replace default neovim
```nix
nixvim = final: prev: {
  neovim = inputs.nixvim.packages."${prev.system}".default;
};
```

Install neovim normally, system-wide or using home-manager.\
The overlay ensures the right package is installed.
```nix
home.packages = with pkgs; [ neovim ];
environment.systemPackages = with pkgs; [ neovim ];
```


## Checking for new plugins

[`list-plugin-releases.py`](./list-plugin-releases.py) will check for new plugin releases since the currently locked nixvim version.

```bash
./list-plugin-releases.py -t [github_token]
```
