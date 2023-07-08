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
    };
  };
}
