{
  programs.helix = {
    enable = true;
    settings = {
      editor.idle-timeout = 0;
      editor.cursor-shape = {
        insert = "bar";
        normal = "underline";
        select = "underline";
      };
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
