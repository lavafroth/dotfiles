# Dotfiles

NixOS configuration files personalized for my workflow.

To get started, install NixOS, [enable flakes](https://nixos.wiki/wiki/Flakes#NixOS), clone this repository.

```sh
git clone https://github.com/lavafroth/dotfiles
cd dotfiles
sudo nixos-rebuild switch --flake .#cafe
```

### Secureboot

To enable secureboot, generate your keys, clear the manufacturer keys and enroll them as described [here](https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md).
> Note: `sbctl` is already installed

Once the keys are enrolled, we must run the following to rebuild our system from now on

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
