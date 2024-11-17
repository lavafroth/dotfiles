{ pkgs, ... }:
{
  home-manager.users.h = import ../home/gnome.nix;
  services.gnome.tinysparql.enable = true;
  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  environment.gnome.excludePackages = with pkgs; [
    evince
    epiphany
    geary
    gnome-text-editor
    gnome-tour
    yelp
    totem
  ];

  # remove this after https://github.com/NixOS/nixpkgs/issues/353990 is fixed
  environment.variables = {
    GSK_RENDERER = "gl";
  };

}
