# Dotfiles

NixOS configuration files personalized for my workflow.

To get started, install NixOS, [enable flakes](https://nixos.wiki/wiki/Flakes#NixOS), clone this repository.

```sh
git clone --recursive https://github.com/lavafroth/dotfiles
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

#### Optional: Installing Sponsorblock for mpv

A fresh install is unlikely to have Rust and thus, the sponsorblock
library won't be installed. Since I won't be uploading the compiled shared
object, you have to compile it yourself. After the first rebuild, run:

```sh
pushd sources/mpv-sponsorblock
cargo build --release --locked
cp ./target/release/libmpv_sponsorblock.so ../mpv/scripts/sponsorblock.so
popd
```

followed by another rebuild.