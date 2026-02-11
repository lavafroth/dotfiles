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
    ./gaming.nix
    ./git.nix
    ./golang.nix
    ./graphics.nix
    ./helix.nix
    ./nixlang.nix
    ./notetaking.nix
    ./python.nix
    ./rust.nix
    ./shell.nix
    ./video-editing.nix
    ./media-playback.nix
    ./mpv.nix
  ];

  xdg.enable = true;
  home = {
    sessionVariables = {
      # these mfs pollute my home directory
      # some unfixable offenders include .mozilla, .librewolf
      # .adb and .ghidra

      SCIKIT_LEARN_DATA = "${config.xdg.cacheHome}/sklearn-data";
      CUDA_CACHE_PATH = "${config.xdg.cacheHome}/nv";
      NH_FLAKE = "${config.xdg.userDirs.publicShare}/dotfiles";
      GDBHISTFILE = "${config.xdg.dataHome}/gdb/history";

      HISTFILE="${config.xdg.stateHome}/bash/history";
      KERAS_HOME="${config.xdg.stateHome}/keras";
      ANDROID_USER_HOME="${config.xdg.dataHome}/android";
      W3M_DIR="${config.xdg.dataHome}/w3m";

      # Remove when https://github.com/flxzt/rnote/issues/1543 gets fixed.
      # causes the drawing tablet input to not get recognized.
      GDK_BACKEND="x11";

      GNUPGHOME = "${config.xdg.dataHome}/gnupg";

      GOPATH = "${config.xdg.userDirs.publicShare}/go";
      GOBIN = "${config.home.sessionVariables.GOPATH}/bin";

      JUPYTER_PLATFORM_DIRS = "1";

      _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${config.xdg.configHome}/java";

      JULIAUP_DEPOT_PATH = "${config.xdg.dataHome}/julia";
      CARGO_HOME = "${config.xdg.dataHome}/cargo";
      PSQL_HISTORY = "${config.xdg.stateHome}/psql_history";
      PYTHON_HISTORY = "${config.xdg.stateHome}/python_history";
      SQLITE_HISTORY="${config.xdg.stateHome}/sqlite_history";
    };

    sessionPath = [
      config.home.sessionVariables.GOBIN
      "${config.home.homeDirectory}/.cargo/bin"
    ];
    stateVersion = "24.05";

    packages = with pkgs; [
      kiwix
      kiwix-tools
      tesseract
      signal-desktop-bin
      (pkgs.writeShellScriptBin "lecture" ''
        mpv --speed=1.5 --start=00:00:14 --cache-pause-wait=14 --script-opts='skipsilence-enabled=yes,skipsilence-threshold_db=-18' --vf=sub,negate "$1"
      '')
    ];
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

    kitty = {
      enable = true;
      settings = {
        confirm_os_window_close = 0;
        enable_audio_bell = false;
        window_padding_width = "6 10";
        cursor_shape = "block";
        cursor_trail = 1;
        cursor_trail_decay = "0.1 0.3";
        cursor_trail_start_threshold = 0;
        shell_integration = "no-cursor";
        font_size = 13.0;
        tab_bar_margin_height = "8.0 0.0";
        tab_bar_style = "powerline";
        tab_powerline_style = "slanted";
      };
      keybindings = {
        "ctrl+t" = "new_tab_with_cwd";
        "ctrl+shift+t" = "";
        "ctrl+backspace" = "send_text all \\x17";
      };
    };
  };
}
