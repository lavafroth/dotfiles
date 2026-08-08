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

    config = {
      keepaspect-window="no";
      keepaspect="yes";
      blend-subtitles="video";
    };
  };

  home.packages = with pkgs; [
    yt-dlp
  ];
}
