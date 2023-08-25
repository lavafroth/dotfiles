# Dotfiles

NixOS configuration files personalized for my workflow.

To get started, install NixOS, [enable flakes](https://nixos.wiki/wiki/Flakes#NixOS), clone this repository.

```sh
git clone --recursive https://github.com/lavafroth/dotfiles
cd dotfiles
```

Now run the following rebuild command:

```sh
nix develop
sudo cafe-rebuild switch
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