{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./aws.nix
    ./benchmarking.nix
    ./browsers.nix
    ./ctf.nix
    # ./gaming.nix
    ./git.nix
    # ./gnome.nix
    ./golang.nix
    ./graphics.nix
    ./helix.nix
    # ./hud.nix
    ./nixlang.nix
    ./notetaking.nix
    ./python.nix
    ./rust.nix
    ./shell.nix
    ./video-editing.nix
    ./zellij.nix
    ./media-playback.nix
  ];

  home = {
    file = {
      ".config/mpv" = {
        source = ./sources/mpv;
        recursive = true;
      };
      ".config/mpv/scripts/sponsorblock.so" = {
        source = "${pkgs.sponsorblock-lib.out}/lib/libmpv_sponsorblock.so";
      };
    };

    sessionVariables = {
      # these mfs pollute my home directory
      # some unfixable offenders include .mozilla, .librewolf
      # .adb and .ghidra
      CUDA_CACHE_PATH = "${config.xdg.cacheHome}/nv";
      FLAKE = "${config.xdg.userDirs.publicShare}/dotfiles";
      GDBHISTFILE = "${config.xdg.dataHome}/gdb/history";

      GNUPGHOME = "${config.xdg.dataHome}/gnupg";

      GOPATH = "${config.xdg.userDirs.publicShare}/go";
      GOBIN = "${config.home.sessionVariables.GOPATH}/bin";

      JUPYTER_PLATFORM_DIRS = "1";

      _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${config.xdg.configHome}/java";

      JULIAUP_DEPOT_PATH = "${config.xdg.dataHome}/julia";
      CARGO_HOME = "${config.xdg.dataHome}/cargo";
    };

    sessionPath = [
      config.home.sessionVariables.GOBIN
      "${config.home.homeDirectory}/.cargo/bin"
    ];
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
