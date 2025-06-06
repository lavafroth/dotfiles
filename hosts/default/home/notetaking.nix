{ pkgs, ... }:
{
  home.packages = with pkgs; [
    mdcat
    iwe
    typst
    rnote
  ];
}
