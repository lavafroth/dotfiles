{ pkgs, ... }: {
  home.packages = with pkgs; [
    krita
    inkscape
    blender
  ];
}
