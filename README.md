# Dotfiles

NixOS configuration files personalized for my workflow.

To get started, install NixOS, [enable flakes](https://nixos.wiki/wiki/Flakes#NixOS)
and clone this repository.

```sh
git clone https://github.com/lavafroth/dotfiles
cd dotfiles
sudo nixos-rebuild switch --flake .#cafe-nosecureboot
```

### Secureboot

To enable secureboot, use the preinstalled `sbctl` command to generate your keys,
clear the manufacturer keys and enroll yours as described [here](https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md).

> Note: My system did not require enrolling Microsoft keys alongside my own. However, your setup might break if you do not include the Microsoft keys. Classic case of Microsoft being a jerk.

Once the keys are enrolled, run the following to rebuild the system from now on

```sh
sudo nixos-rebuild switch --flake .
```

### Sponsorblock for mpv

Optionally, if you want to block sponsors in mpv, run

```sh
pushd sources/mpv-sponsorblock
mkdir sources/mpv/scripts
nix build
cp result/lib/libmpv_sponsorblock.so ../mpv/scripts/sponsorblock.so
popd
```

followed by another rebuild.

## Troubleshooting

### command-not-found unable to connect to database

The programs.sqlite is only generated for the nixos- prefixed channels.

Run the following as root:

```sh
nix-channel --add https://nixos.org/channels/nixos-unstable nixos
nix-channel --update
```

Further reading: [NixOS discourse](https://discourse.nixos.org/t/command-not-found-unable-to-open-database/3807).
