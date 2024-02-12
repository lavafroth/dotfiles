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

    "org/gnome/desktop/app-folders/folders/Office" = {
      name = "Office";
      apps = [
        "startcenter.desktop"
        "base.desktop"
        "writer.desktop"
        "calc.desktop"
        "impress.desktop"
        "draw.desktop"
        "math.desktop"
      ];
    };

    "org/gnome/desktop/app-folders/folders/Programming" = {
      name = "Programming";
      apps = [
        "jupyterlab.desktop"
        "jupyter-notebook.desktop"
        "Helix.desktop"
        "ghidra.desktop"
      ];
    };

    "org/gnome/desktop/app-folders/folders/Graphics" = {
      name = "Graphics";
      apps = [
        "org.kde.krita.desktop"
        "gimp.desktop"
        "com.github.flxzt.rnote.desktop"
      ];
    };

    "org/gnome/desktop/app-folders/folders/AltBrowsers" = {
      name = "Alt Browsers";
      apps = [
        "torbrowser.desktop"
        "chromium-browser.desktop"
      ];
    };

    "org/gnome/desktop/app-folders".folder-children = [
      "Utilities"
      "Office"
      "Programming"
      "Graphics"
      "AltBrowsers"
    ];

    # notebooks with touchpads
    "org/gnome/desktop/peripherals/touchpad".tap-to-click = true;

    # disable hot corners
    "org/gnome/desktop/interface".enable-hot-corners = false;
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
