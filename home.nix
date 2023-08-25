{ config, pkgs, ... }:

{

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
      ".local/share/blackbox/schemes/lain.json".source = ./sources/blackbox/lain.json;
    };
  };
}
