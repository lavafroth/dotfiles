{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    cargo
    cargo-machete
    clippy
    evcxr
    rust-analyzer
    rustc
    rustfmt
  ];
}
