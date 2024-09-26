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

To enable secureboot, use the preinstalled `sbctl` command to generate your keys,
clear the manufacturer keys and enroll yours as described [here](https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md).

> Note: My system did not require enrolling Microsoft keys alongside my own. However, your setup might break if you do not include the Microsoft keys. Classic case of Microsoft being a jerk.

Once the keys are enrolled, run the following to rebuild the system from now on

```sh
sudo nixos-rebuild switch --flake dotfiles
```

#### Sponsorblock for mpv

Optionally, if you want to block sponsors in mpv, run

```sh
pushd dotfiles/hosts/default/sources/mpv-sponsorblock
mkdir dotfiles/hosts/default/sources/mpv/scripts
nix build
cp result/lib/libmpv_sponsorblock.so ../mpv/scripts/sponsorblock.so
popd
```

followed by another rebuild.

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

## Troubleshooting

### command-not-found unable to connect to database

The `programs.sqlite` is only generated for the `nixos-` prefixed channels.
Ensure you use the unstable channel using these commands as root:

```sh
nix-channel --add https://nixos.org/channels/nixos-unstable nixos
nix-channel --update
```

Further reading: [NixOS discourse](https://discourse.nixos.org/t/command-not-found-unable-to-open-database/3807).

### Running blender with CUDA

```
nix run --impure github:guibou/nixGL -- nix run blender-bin
```
