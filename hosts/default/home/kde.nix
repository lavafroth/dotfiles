{ pkgs, ... }:
{
  home.packages = with pkgs; [
    keepassxc
    kdePackages.kde-gtk-config
    kdePackages.kclock
    kdePackages.alligator
    kdePackages.karousel
    kde-rounded-corners
    notify-desktop
  ];
}
