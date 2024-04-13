{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    hyperfine
    linuxPackages_latest.perf
  ];
}
