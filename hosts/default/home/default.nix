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
    ./helix.nix
    ./nixlang.nix
    ./notetaking.nix
    ./python.nix
    ./rust.nix
    ./shell.nix
    ./creative-suite.nix
    ./media-playback.nix
  ];

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    setSessionVariables = true;

    desktop = "${config.home.homeDirectory}/desktop";
    documents = "${config.home.homeDirectory}/documents";
    publicShare = "${config.home.homeDirectory}/public";
    download = "${config.home.homeDirectory}/downloads";
    music = "${config.home.homeDirectory}/music";
    pictures = "${config.home.homeDirectory}/pictures";
    videos = "${config.home.homeDirectory}/videos";
    templates = "${config.home.homeDirectory}/templates";
    projects = "${config.home.homeDirectory}/projects";

  };
  home = {
    sessionVariables = {
      # these mfs pollute my home directory
      # some unfixable offenders include
      # .adb and .ghidra
      SCIKIT_LEARN_DATA = "${config.xdg.cacheHome}/sklearn-data";
      CUDA_CACHE_PATH = "${config.xdg.cacheHome}/nv";
      NH_FLAKE = "${config.xdg.userDirs.projects}/dotfiles";
      GDBHISTFILE = "${config.xdg.dataHome}/gdb/history";

      HISTFILE = "${config.xdg.stateHome}/bash/history";
      KERAS_HOME = "${config.xdg.stateHome}/keras";
      ANDROID_USER_HOME = "${config.xdg.dataHome}/android";
      W3M_DIR = "${config.xdg.dataHome}/w3m";

      GNUPGHOME = "${config.xdg.dataHome}/gnupg";

      GOPATH = "${config.xdg.userDirs.projects}/go";
      GOBIN = "${config.home.sessionVariables.GOPATH}/bin";

      JUPYTER_PLATFORM_DIRS = "1";

      _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${config.xdg.configHome}/java";

      JULIAUP_DEPOT_PATH = "${config.xdg.dataHome}/julia";
      CARGO_HOME = "${config.xdg.dataHome}/cargo";
      PSQL_HISTORY = "${config.xdg.stateHome}/psql_history";
      PYTHON_HISTORY = "${config.xdg.stateHome}/python_history";
      SQLITE_HISTORY = "${config.xdg.stateHome}/sqlite_history";
      XCOMPOSECACHE = "${config.xdg.cacheHome}/X11/xcompose";

      YDOTOOL_SOCKET = "$XDG_RUNTIME_DIR/.ydotool_socket";
    };

    sessionPath = [
      config.home.sessionVariables.GOBIN
      "${config.home.homeDirectory}/.cargo/bin"
    ];

    stateVersion = "26.05";

    packages = with pkgs; [
      kiwix
      ydotool
      newsboat
      anki
      kiwix-tools
      harper
      tesseract
      whisper-cpp
      signal-desktop
      android-tools
      dust

      (pkgs.writeShellScriptBin "lecture" ''
        mpv --speed=1.5 --start=00:00:14 --cache-pause-wait=14 --script-opts='skipsilence-enabled=yes,skipsilence-threshold_db=-18' --vf=sub,negate "$1"
      '')
      (pkgs.writeShellScriptBin "transcribe" ''
        MODEL=$1
        WAVFILE="/tmp/whisper.wav"

        if test ! -f "$WAVFILE"; then
          ${pkgs.notify-desktop}/bin/notify-desktop "Recording audio" "Re-trigger the shortcut to transcribe"
          nohup pw-record $WAVFILE &
          disown -a
          exit
        fi

        ${pkgs.busybox}/bin/fuser -k -INT "$WAVFILE"
        ${pkgs.notify-desktop}/bin/notify-desktop "Starting transcription" "using model $MODEL"
        ${pkgs.whisper-cpp}/bin/whisper-cli -m "$MODEL" -f "$WAVFILE" --output-txt
        tr -d '\n' < /tmp/whisper.wav.txt | wl-copy
        rm "$WAVFILE"
        ydotool key 29:1 47:1 47:0 29:0
      '')

      (pkgs.writeShellScriptBin "adb" ''
        env HOME="${config.xdg.dataHome}/android" ${pkgs.android-tools}/bin/adb "$@"
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
