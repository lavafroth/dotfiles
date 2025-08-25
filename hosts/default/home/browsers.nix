{ pkgs, ... }:
{
  home.packages = with pkgs; [
    arti
    librewolf
    ungoogled-chromium
    brave
  ];
}
