{ pkgs, ... }:
{
  home-manager.users.h = import ../home/kde.nix;
  services = {
    desktopManager.plasma6.enable = true;

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
  environment.systemPackages = with pkgs; [
    kdePackages.sddm-kcm
    plasma-panel-colorizer
  ];

  environment.plasma6.excludePackages = with pkgs; [
    konsole
    kdePackages.oxygen-icons
    kdePackages.kate
    kdePackages.plasma-workspace-wallpapers
  ];
}
