{pkgs, ...}:
{ 

  stylix.enable = true;
  stylix.image = ./sources/stylix_image.jpg;
  # stylix.polarity = "dark";
  stylix.base16Scheme = {
  base00= "2d141a";
  base01= "891b12";
  base02= "79628e";
  base03= "e98164";
  base04= "f3a676";
  base05= "f7e1af";
  base06= "f9efe3";
  base07= "fff0d6";
  base08= "e76869";
  base09= "e46e43";
  base0A= "e66684";
  base0B= "e96850";
  base0C= "da7358";
  base0D= "d37849";
  base0E= "ea6472";
  base0F= "d47565";
   };

  # stylix.targets.fish.enable = false;

  stylix.fonts = {
    serif = {
      package = pkgs.terminus-nerdfont;
      name = "Terminess NerdFont";
    };

    sansSerif = {
      package = pkgs.terminus-nerdfont;
      name = "Terminess NerdFont";
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

}
