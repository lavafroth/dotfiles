{ config, pkgs, ... }:

{
  imports  = [
    # nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager
    # nix-channel --update
    <home-manager/nixos>
  ];

  home-manager.users.h = {
    home.stateVersion = "23.05";

    home.file = {
      ".config/helix/config.toml".source = ./sources/helix/config.toml;
      ".config/fish" = {
        source = ./sources/fish;
        recursive = true;
      };
    ".config/mpv" = {
        source = ./sources/mpv;
        recursive = true;
      };
      # Do not display fish in the menu
      ".local/share/applications/fish.desktop".source = ./sources/fish.desktop;
      ".local/share/blackbox/schemes/tokyonight.json".source = ./sources/blackbox/tokyonight.json;
    };
  };
}
