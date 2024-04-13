{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    glow
    marksman
    rnote
  ];
}
