{
  home.file.".config/zellij/layouts/minimal.kdl".source = ./sources/zellij/minimal.kdl;
  programs.zellij = {
    enable = true;
    settings = {
      copy_command = "wl-copy";
      simplified_ui = true;
      pane_frames = false;
      default_layout = "minimal";
    };
  };
}
