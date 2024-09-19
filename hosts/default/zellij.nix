{
  home.file.".config/zellij/layouts/minimal.kdl".source = ./sources/zellij/minimal.kdl;
  programs.zellij = {
    enable = true;
    # enableFishIntegration = true;
    settings = {
      copy_command = "wl-copy";
      simplified_ui = true;
      pane_frames = false;
      default_layout = "minimal";

      themes = {
        hel = {
          fg = "#d14231";
          bg = "#121212";
          black = "#000000";
          red = "#fc564d";
          green = "#fc564d";
          yellow = "#D79921";
          blue = "#3C8588";
          magenta = "#B16286";
          cyan = "#689D6A";
          white = "#FBF1C7";
          orange = "#D65D0E";
        };
      };

      theme = "hel";
    };
  };
}
