{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    dxvk
    wine64
    lutris
  ];
}
