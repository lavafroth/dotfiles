{ pkgs, ... }:
{
  home.packages = with pkgs; [
    mdcat
    marksman
    rnote
    apostrophe
  ];
}
