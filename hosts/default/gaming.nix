{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    lutris
    wine
    dxvk
    bottles
  ];
}
