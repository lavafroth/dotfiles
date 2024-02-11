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
    };

    sessionVariables = {
      GOPATH = "${config.home.homeDirectory}/Public/go";
      GOBIN = "${config.home.sessionVariables.GOPATH}/bin";
    };

    packages = with pkgs.gnomeExtensions; [
      blur-my-shell
      quick-settings-tweaker
      user-themes
      caffeine
      rounded-window-corners
    ];

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

    "org/gnome/shell".enabled-extensions = [
      "quick-settings-tweaks@qwreey"
      "caffeine@patapon.info"
      "blur-my-shell@aunetx"
    ];

    "org/gnome/mutter".dynamic-workspaces = true;

    "org/gnome/shell".favorite-apps = [
      "org.gnome.Console.desktop"
      "librewolf.desktop"
      "org.gnome.Nautilus.desktop"
      "org.gnome.World.Secrets.desktop"
      "signal-desktop.desktop"
    ];

  };

  xdg.desktopEntries.ocr = {
    name = "Screen Grab OCR";
    exec = "${pkgs.writeScript "ocr" ''
      ${pkgs.gnome.gnome-screenshot}/bin/gnome-screenshot --area --file /tmp/ocr-tmp.png
      ${pkgs.tesseract}/bin/tesseract /tmp/ocr-tmp.png - | ${pkgs.wl-clipboard}/bin/wl-copy
      rm /tmp/ocr-tmp.png
    ''}";
  };
 
}
