{ config, ... }:

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
    };

    sessionVariables = {
      GOPATH = "${config.home.homeDirectory}/Public/go";
      GOBIN = "${config.home.sessionVariables.GOPATH}/bin";
    };

    stateVersion = "24.05";
  };

  dconf.settings = {

    # Did you know I'm a programmer?
    "org/gnome/calculator" = {
      button-mode = "programming";
      show-thousands = true;
      base = 10;
    };

    # Enable dark theme using adw-gtk3 to make GTK3 apps look coherent
    "org/gnome/desktop/interface" = {
      gtk-theme = "adw-gtk3-dark";
      color-scheme = "prefer-dark";
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
    };
  };
}
