# Dotfiles

NixOS configuration files personalized for my workflow.

To get started, install NixOS, clone this repository and run the rebuild command.

```sh
git clone --recursive https://github.com/lavafroth/dotfiles
```

```sh
sudo nixos-rebuild switch -I nixos-config=configuration.nix
```

#### Optional: Installing Sponsorblock for mpv

A fresh install is unlikely to have Rust and thus, the sponsorblock
library won't be installed. Since I won't be uploading the compiled shared
object, you have to compile it yourself. After the first `nixos-rebuild`, run:

```sh
pushd sources/mpv-sponsorblock
cargo build --release --locked
cp ./target/release/libmpv_sponsorblock.so ../mpv/scripts/sponsorblock.so
popd
```

followed by the aforementioned `nixos-rebuild` command.