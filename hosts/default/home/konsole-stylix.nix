{
  pkgs,
  lib,
  ...
}:
{
  home.activation.konsolerc = lib.hm.dag.entryAfter [ "stylixLookAndFeel" ] ''
    ${pkgs.mustache2konsole}/bin/mustache2konsole $HOME/.config/stylix/palette.json > $HOME/.local/share/konsole/Stylix.colorscheme
  '';
}
