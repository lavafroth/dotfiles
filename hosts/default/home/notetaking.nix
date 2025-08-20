{ pkgs, ... }:
{
  home.packages = with pkgs; [
    mdcat
    typst
    rnote
  ];
}
