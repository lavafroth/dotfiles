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
    ./zellij.nix
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
      CUDA_CACHE_PATH = "${config.xdg.cacheHome}/nv";
      FLAKE = "${config.xdg.userDirs.publicShare}/dotfiles";
      GDBHISTFILE = "${config.xdg.dataHome}/gdb/history";

      GNUPGHOME = "${config.xdg.dataHome}/gnupg";

      GOPATH = "${config.xdg.userDirs.publicShare}/go";
      GOBIN = "${config.home.sessionVariables.GOPATH}/bin";

      _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${config.xdg.configHome}/java";
      };

    sessionPath = [ config.home.sessionVariables.GOBIN "${config.home.homeDirectory}/.cargo/bin" ];
    stateVersion = "24.05";
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
