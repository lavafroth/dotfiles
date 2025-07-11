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
  ];

  environment.plasma6.excludePackages = with pkgs; [
    kdePackages.oxygen-icons
    kdePackages.kate
    kdePackages.plasma-workspace-wallpapers
    kdePackages.elisa
    kdePackages.kwallet
    kdePackages.konsole
    kdePackages.kwallet-pam
  ];
}
