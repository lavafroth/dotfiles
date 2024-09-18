{
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      copy_command = "wl-copy";
      simplified_ui = true;
      pane_frames = false;
    };
    home.file.".config/zellij/layouts/minimal.kdl" = ./sources/zellij/minimal.kdl;
  };
}
