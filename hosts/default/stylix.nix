{ pkgs, ... }:
{

  stylix.enable = true;
  stylix.image = ./home/sources/stylix_image.png;
  stylix.polarity = "dark";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

  stylix.fonts = {
    serif = {
      package = pkgs.barlow;
      name = "Barlow Light";
    };

    sansSerif = {
      package = pkgs.barlow;
      name = "Barlow Light";
    };

    monospace = {
      package = pkgs.terminus-nerdfont;
      name = "Terminess NerdFont";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };

  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Ice";
}
