{ pkgs, ... }: {
  home.packages = with pkgs; [
    ffmpeg-full
    kdePackages.kdenlive
    audacity
    blender
    inkscape
    godot
    krita
    libresprite
  ];
}
