{ pkgs, ... }:
{
  home.packages = with pkgs; [
    krita
    inkscape
    libresprite
    # blender
  ];
}
