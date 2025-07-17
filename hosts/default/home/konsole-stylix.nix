{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.activation.konsolerc = lib.hm.dag.entryAfter [ "stylixLookAndFeel" ] ''
    PATH="${config.home.path}/bin:$PATH:${pkgs.jq}"
    palette=$HOME/.config/stylix/palette.json
    scheme=$HOME/.local/share/konsole/Stylix.colorscheme
    profile=$HOME/.local/share/konsole/Stylix.profile

    if ! [ -f $palette ]; then
      echo "Palette doesn't exist"
    else
      json=$( cat $palette )

      hex_to_rgb() {
        hex=$1
        r=$((16#''${hex:0:2}))
        g=$((16#''${hex:2:2}))
        b=$((16#''${hex:4:2}))
        echo "$r,$g,$b"
      }

      for base in base00 base01 base02 base03 base04 base05 base06 base07 base08 base09 base0A base0B base0C base0D base0E base0F; do
        hex=$(echo "$json" | jq -r ".$base")
        rgb=$(hex_to_rgb "$hex")
        declare "''${base}_rgb=$rgb"
      done

      echo "
      [Background]
      Color=$base00_rgb
      [BackgroundIntense]
      Color=$base03_rgb
      [Color0]
      Color=$base00_rgb
      [Color0Intense]
      Color=$base03_rgb
      [Color1]
      Color=$base08_rgb
      [Color1Intense]
      Color=$base08_rgb
      [Color2]
      Color=$base0B_rgb
      [Color2Intense]
      Color=$base0B_rgb
      [Color3]
      Color=$base0A_rgb
      [Color3Intense]
      Color=$base0A_rgb
      [Color4]
      Color=$base0D_rgb
      [Color4Intense]
      Color=$base0D_rgb
      [Color5]
      Color=$base0E_rgb
      [Color5Intense]
      Color=$base0E_rgb
      [Color6]
      Color=$base0C_rgb
      [Color6Intense]
      Color=$base0C_rgb
      [Color7]
      Color=$base05_rgb
      [Color7Intense]
      Color=$base07_rgb
      [Foreground]
      Color=$base05_rgb
      [ForegroundIntense]
      Color=$base07_rgb
      [General]
      Description=Stylix
      Wallpaper=
      " > $scheme

      echo "
      [Appearance]
      ColorScheme=Stylix
      " > $profile
    fi

  '';
}
