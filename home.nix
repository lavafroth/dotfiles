{ config, pkgs, ... }:

{

  imports = [ ./gnome.nix ];

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

  xdg.desktopEntries.ocr = {
    name = "Screen Grab OCR";
    exec = "${pkgs.writeScript "ocr" ''
      ${pkgs.gnome.gnome-screenshot}/bin/gnome-screenshot --area --file /tmp/ocr-tmp.png
      ${pkgs.tesseract}/bin/tesseract /tmp/ocr-tmp.png - | ${pkgs.wl-clipboard}/bin/wl-copy
      rm /tmp/ocr-tmp.png
    ''}";
  };

  programs.git = {
    enable = true;
    userName = "Himadri Bhattacharjee";
    userEmail = "107522312+lavafroth@users.noreply.github.com";
    delta.enable = true;

    extraConfig = {
      credential."https://github.com".helper = "${pkgs.gh}/bin/gh auth git-credential";
      credential."https://gist.github.com".helper = "${pkgs.gh}/bin/gh auth git-credential";
      gpg.format = "ssh";
    };
    signing.signByDefault = true;
    signing.key = "${config.home.homeDirectory}/.ssh/id_ed25519";

  };
 
}
