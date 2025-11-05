{ pkgs, ... }:
{
  home.packages = with pkgs; [
    arti
    librewolf
    brave
    ungoogled-chromium
  ];
}
