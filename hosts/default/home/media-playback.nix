{ pkgs, ... }:
{
  programs.mpv = {
    enable = true;

    package = (
      pkgs.mpv.override {
        scripts = with pkgs.mpvScripts; [
          mpris
          sponsorblock
          skipsilence
        ];
      }
    );
  };

  home.packages = with pkgs; [
    yt-dlp
  ];
}
