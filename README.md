# Dotfiles

NixOS configuration files personalized for my workflow.

To get started, install NixOS, clone this repository and run:

```sh
sudo nixos-rebuild switch -I nixos-config=configuration.nix
```

# Compiling the Sponsorblock library for mpv

For the first install, you won't get the sponsorblock library installed
since a bare install probably won't have Rust to compile it and I'm not
going to upload a compiled shared library to this repository. After the
first install, run:

```sh
git submodule update --init --recursive
pushd sources/mpv-sponsorblock
cargo build --release --locked
cp ./target/release/libmpv_sponsorblock.so ../mpv/scripts/sponsorblock.so
popd
```

followed by the aforementioned `nixos-rebuild` command.