{ pkgs, ... }:
{
  home.packages = with pkgs; [
    mdcat
    iwe
    rnote
    apostrophe
  ];
}
