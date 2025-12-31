{ pkgs, ... }:
{
  home.packages = with pkgs; [
    mdcat
    typst
    iwe
    rnote
  ];
}
