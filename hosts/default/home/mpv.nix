{ pkgs, ... }:
{
  programs.mpv = {
    enable = true;

    package = (
      pkgs.mpv.override {
       # waylandSupport = true;

        scripts = with pkgs.mpvScripts; [
          mpris
          sponsorblock
          skipsilence
        ];
      }
    );
  };
}
