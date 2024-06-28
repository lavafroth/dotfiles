{ config, pkgs, ... }:

{
  imports = [
    ./aws.nix
    ./benchmarking.nix
    ./ctf.nix
    ./gaming.nix
    ./git.nix
    ./graphics.nix
    # ./gnome.nix
    ./helix.nix
    ./kde.nix
    ./browsers.nix
    ./notetaking.nix
    ./python.nix
    ./rust.nix
    ./shell.nix
    # ./hud.nix
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
      FLAKE = "${config.home.homeDirectory}/Public/dotfiles";
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

  xdg.desktopEntries.andcam = {
    name = "Android Virtual Camera";
    exec = "${pkgs.writeScript "andcam" ''
      ${pkgs.android-tools}/bin/adb start-server
      ${pkgs.scrcpy}/bin/scrcpy --video-source=camera --no-audio --camera-facing=back --v4l2-sink=/dev/video0 -m1024
    ''}";
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
