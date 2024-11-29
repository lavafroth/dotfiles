{ pkgs, ... }:
{
  home.packages =
    with pkgs.gnomeExtensions;
    [
      blur-my-shell
      user-themes
      caffeine
      paperwm
      pano
    ]
    ++ (with pkgs; [
      adw-gtk3
      gnome-secrets
      papers
      celluloid
      fractal
    ]);
  # the above two get merged

  home.programs.helix.settings.theme = "adwaita-dark";

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
      "org.gnome.Console.desktop"
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
        "tenacity.desktop"
        "com.github.iwalton3.jellyfin-media-player.desktop"
        "io.github.celluloid_player.Celluloid.desktop"
        "org.kde.kdenlive.desktop"
        "org.gnome.Music.desktop"
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
        "org.inkscape.Inkscape.desktop"
      ];
    };

    "org/gnome/desktop/app-folders/folders/System" = {
      name = "System";
      apps = [
        "org.gnome.Settings.desktop"
        "org.gnome.SystemMonitor.desktop"
        "org.gnome.DiskUtility.desktop"
        "org.gnome.baobab.desktop"
        "org.gnome.seahorse.Application.desktop"
        "org.gnome.Logs.desktop"
      ];
    };

    "org/gnome/desktop/app-folders/folders/AltProfiles" = {
      name = "Alt Profiles";
      apps = [
        "torbrowser.desktop"
        "google-profile.desktop"
        "github-profile.desktop"
      ];
    };

    "org/gnome/desktop/app-folders".folder-children = [
      "Utilities"
      "Office"
      "Programming"
      "Graphics"
      "AltProfiles"
      "System"
      "SoundAndVideo"
    ];

    "org/gnome/desktop/input-sources".xkb-options = [
      "terminate:ctrl_alt_bksp"
      "lv3:ralt_switch"
      "caps:swapescape"
    ];

    # notebooks with touchpads
    "org/gnome/desktop/peripherals/touchpad".tap-to-click = true;

    # disable hot corners
    "org/gnome/desktop/interface".enable-hot-corners = false;
    "org/gnome/desktop/peripherals/touchpad".click-method = "areas";
    "org/gnome/Console".custom-font = "Monaspace Krypton Var 11";
  };
}
