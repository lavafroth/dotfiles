{ config, pkgs, ... }:

{
  home = {
    file = {
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
    stateVersion = "23.05";
  };
}
