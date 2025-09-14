# Dotfiles

NixOS configuration files personalized for my daily driver and home server.

### Work Computer

To get started, install NixOS, [enable flakes](https://nixos.wiki/wiki/Flakes#NixOS)
and clone this repository.

```sh
git clone https://github.com/lavafroth/dotfiles
sudo nixos-rebuild switch --flake dotfiles#cafe-nosecureboot
```

#### Secureboot

- Use the preinstalled `sbctl` command to generate your keys
- Clear the manufacturer keys and enroll yours as described [here](https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md).

> Note: My system did not require enrolling Microsoft keys alongside mine. However, your setup might break if you don't. Research about your device carefully before enrolling keys.

- Run the following to rebuild the system from now on

```sh
sudo nixos-rebuild switch --flake dotfiles
```

### Home Server

Install NixOS with the headless (no GUI) settings. Enable flakes.
Clone this repo, enter the directory and run a rebuild for the host `rahu`.

```sh
git clone https://github.com/lavafroth/dotfiles
sudo nixos-rebuild switch --flake dotfiles#rahu
```

### Android (Nix-on-droid)

I use Nix-on-droid to have Termux with a declarative config. Install
[Nix-on-droid from F-Droid](https://f-droid.org/en/packages/com.termux.nix/) and
enable flakes when prompted. Clone this repo and rebuild the environment.

```sh
git clone https://github.com/lavafroth/dotfiles
nix-on-droid switch --flake dotfiles
```

### Running blender with CUDA

```
nix run --impure github:guibou/nixGL -- nix run blender-bin
```
