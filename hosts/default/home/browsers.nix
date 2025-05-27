{ pkgs, ... }:
{
  home.packages = with pkgs; [
    arti
    cromite
  ];
}
