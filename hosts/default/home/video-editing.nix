{ pkgs, ... }: {
  home.packages = with pkgs; [
    ffmpeg-full
    kdePackages.kdenlive
    tenacity
  ];
}
