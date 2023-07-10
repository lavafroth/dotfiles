# Dotfiles

NixOS configuration files personalized for my workflow.

To get started, install NixOS, clone this repository and run:

```sh
sudo nixos-rebuild switch -I nixos-config=configuration.nix
```

# Compiling the Sponsorblock library for mpv

> Note: This is optional

A fresh install will be unlikely to have Rust and thus, the sponsorblock
library won't be installed. Also, I won't be uploading the compiled shared
object. After the first `nixos-rebuild`, run:

```sh
git submodule update --init --recursive
pushd sources/mpv-sponsorblock
cargo build --release --locked
cp ./target/release/libmpv_sponsorblock.so ../mpv/scripts/sponsorblock.so
popd
```

followed by the aforementioned `nixos-rebuild` command.