{ config, pkgs, ... }:

{
  imports = [
    ./aws.nix
    ./benchmarking.nix
    ./browsers.nix
    ./ctf.nix
    ./gaming.nix
    ./git.nix
    # ./gnome.nix
    ./golang.nix
    ./graphics.nix
    ./helix.nix
    # ./hud.nix
    ./kde.nix
    ./nixlang.nix
    ./notetaking.nix
    ./python.nix
    ./rust.nix
    ./shell.nix
    ./video-editing.nix
    ./zellij.nix
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
