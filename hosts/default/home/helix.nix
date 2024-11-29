{ pkgs, ... }:
{
  home.file.".config/helix/themes/hel.toml".source = ./sources/helix/hel.toml;
  programs.helix = {
    enable = true;
    settings = {
      editor.cursor-shape.insert = "bar";
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
