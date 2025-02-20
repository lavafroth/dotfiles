{ pkgs, ... }:
{
  programs.mpv = {
    enable = true;

    package = (
      pkgs.mpv-unwrapped.wrapper {
        mpv = pkgs.mpv-unwrapped.override {
          waylandSupport = true;
        };

        scripts = with pkgs.mpvScripts; [
          sponsorblock
          skipsilence
        ];
      }
    );
  };
}
