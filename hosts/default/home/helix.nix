{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    settings = {
      theme = pkgs.lib.mkForce "solarized_dark";
      editor.cursor-shape = {
        insert = "bar";
        normal = "bar";
      };
      editor.line-number = "relative";
      editor.idle-timeout = 0;
      keys.normal."X" = [
        "extend_line_up"
        "extend_to_line_bounds"
      ];
      keys.select."X" = [
        "extend_line_up"
        "extend_to_line_bounds"
      ];
      keys.normal."C-g" = [
        ":new"
        ":insert-output ${pkgs.lazygit}/bin/lazygit"
        ":buffer-close!"
        ":redraw"
      ];
    };
  };
}
