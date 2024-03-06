{ config, pkgs, ... }:

{

  imports = [
    ./gnome.nix
    ./aws.nix
    ./git.nix
    ./shell.nix
  ];

  home = {
    file = {
      ".config/mpv" = {
        source = ./sources/mpv;
        recursive = true;
      };
    };

    sessionVariables = {
      GOPATH = "${config.home.homeDirectory}/Public/go";
      GOBIN = "${config.home.sessionVariables.GOPATH}/bin";
      CUDA_CACHE_PATH = "${config.xdg.cacheHome}/nv";
    };

    sessionPath = [ config.home.sessionVariables.GOBIN "${config.home.homeDirectory}/.cargo/bin" ];
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

  programs = {

    helix = {
      enable = true;
      settings = {
        theme = "adwaita-dark";
        editor.cursor-shape.insert = "bar";
        editor.line-number = "relative";
        editor.idle-timeout = 0;
      };
    };

  };
}
