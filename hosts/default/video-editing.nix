{ pkgs, ... }: {
  home.packages = with pkgs; [
    ffmpeg-full
    kdenlive
    tenacity
  ];
}
