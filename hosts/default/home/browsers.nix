{ pkgs, ... }:
{
  home.packages = with pkgs; [
    arti
    ungoogled-chromium
    brave
  ];
}
