{ pkgs, ... }:
{

  stylix.enable = true;
  stylix.image = ./home/sources/stylix_image.png;
  stylix.polarity = "dark";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/horizon-terminal-dark.yaml";
  stylix.targets.qt.platform = "kde6";
  # extracted by running
  # `plasma-apply-cursortheme --list-themes`
  # stylix.cursor.name = "Breeze_Light";

  stylix.fonts = rec {
    monospace = {
      package = pkgs.nerd-fonts.terminess-ttf;
      name = "Terminess NerdFont";
    };

    serif = {
      package = pkgs.callPackage ./space-grotesk.nix { };
      name = "Space Grotesk";
    };
    sansSerif = serif;

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
    sizes = {
      desktop = 10;
      terminal = 10;
    };
  };
}
