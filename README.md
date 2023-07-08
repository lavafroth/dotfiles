# Dotfiles

NixOS configuration files personalized for my workflow.

To get started, install NixOS, clone this repository and run:

```sh
nixos-rebuild switch -I nixos-config=configuration.nix
```

I use `rustup` to manage the Rust toolchain including `cargo`, `rustc` and `rust-analyzer`.
My editor `helix` is automatically able to utilize `rust-analyzer` as a language server.
To reproduce my `rustup` config, run the following:

```sh
rustup install stable
rustup component add rust-src
rustup component add rust-analyzer
```