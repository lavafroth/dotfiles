{ config, pkgs, ... }: {

  home.packages = with pkgs.gnomeExtensions; [
    blur-my-shell
    quick-settings-tweaker
    user-themes
    caffeine
    paperwm
  ] ++ [
    pkgs.blackbox-terminal
  ];

  # the above two get merged

  home.file.".config/paperwm/user.css".source = ./sources/paperwm/user.css;

  # Refer to https://hoverbear.org/blog/declarative-gnome-configuration-in-nixos/
  dconf.settings = {
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
      "paperwm@paperwm.github.com"
    ];

    "org/gnome/mutter".dynamic-workspaces = true;

    "org/gnome/shell".favorite-apps = [
      "com.raggesilver.BlackBox.desktop"
      "librewolf.desktop"
      "org.gnome.Nautilus.desktop"
      "org.gnome.World.Secrets.desktop"
      "signal-desktop.desktop"
      "net.lutris.Lutris.desktop"
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

    "org/gnome/desktop/app-folders/folders/SoundAndVideo" = {
      name = "Sound & Video";
      apps = [
        "com.github.iwalton3.jellyfin-media-player.desktop"
        "io.github.celluloid_player.Celluloid.desktop"
        "org.kde.kdenlive.desktop"
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
        "io.gitlab.theevilskeleton.Upscaler.desktop"
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
      "SoundAndVideo"
    ];

    # notebooks with touchpads
    "org/gnome/desktop/peripherals/touchpad".tap-to-click = true;

    # disable hot corners
    "org/gnome/desktop/interface".enable-hot-corners = false;
  };
}
