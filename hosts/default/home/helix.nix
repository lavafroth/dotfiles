{
  programs.helix = {
    enable = true;
    settings = {
      editor.idle-timeout = 0;
      keys.normal."X" = [
        "extend_line_up"
        "extend_to_line_bounds"
      ];
      keys.select."X" = [
        "extend_line_up"
        "extend_to_line_bounds"
      ];
    };
  };
}
