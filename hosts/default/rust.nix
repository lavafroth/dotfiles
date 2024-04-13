{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    cargo
    cargo-deny
    clippy
    evcxr
    rust-analyzer
    rustc
    rustfmt
  ];
}
