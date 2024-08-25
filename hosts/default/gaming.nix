{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    wine
    dxvk
    bottles
  ];
}
