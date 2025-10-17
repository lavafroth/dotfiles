# Dotfiles

NixOS configuration files personalized for my daily driver and home server.

## Work Computer

- Install NixOS
- [Enable flakes](https://nixos.wiki/wiki/Flakes#NixOS)
- Run the following

```sh
sudo nixos-rebuild switch --flake github:lavafroth/dotfiles#cafe-nosecureboot
```

### Secureboot

- Use the preinstalled `sbctl` command to generate your keys
- Clear the manufacturer keys and enroll yours as described [here](https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md).

> Note: My system did not require enrolling Microsoft keys alongside mine. However, your setup might break if you don't. Research about your device carefully before enrolling keys.

- Run the following to rebuild the system from now on

```sh
sudo nixos-rebuild switch --flake github:lavafroth/dotfiles#cafe
```

### Running blender with CUDA

```
nix run --impure github:guibou/nixGL -- nix run blender-bin
```

## Home Server

- Install NixOS with the headless (no GUI) settings
- Enable flakes
- Rebuild with this flake

```sh
sudo nixos-rebuild switch --flake github:lavafroth/dotfiles#rahu
```

