# Dotfiles

NixOS configuration files personalized for my workflow.

To get started, install NixOS, [enable flakes](https://nixos.wiki/wiki/Flakes#NixOS)
and clone this repository.

```sh
git clone https://github.com/lavafroth/dotfiles
cd dotfiles
sudo nixos-rebuild switch --flake .#cafe
```

### Secureboot

To enable secureboot, use the preinstalled `sbctl` command to generate your keys,
clear the manufacturer keys and enroll yours as described [here](https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md).

Once the keys are enrolled, the following command must be run rebuild our system
from now on

```sh
sudo nixos-rebuild switch --flake .#cafe-secureboot
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
