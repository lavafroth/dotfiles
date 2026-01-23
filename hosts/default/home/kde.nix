{ pkgs, ... }:
{
  home.packages = with pkgs; [
    keepassxc
    kdePackages.kde-gtk-config
    kdePackages.kclock
    kdePackages.alligator
    kdePackages.karousel
    notify-desktop
    klassy
  ];
  home.file.".config/kglobalshortcutsrc".source = ./sources/kglobalshortcutsrc;
  home.file.".config/kwinrc".source = ./sources/kwinrc;
}
