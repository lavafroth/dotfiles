{ pkgs, ... }:
{
  imports = [
    ../default/home/helix.nix
    ../default/home/shell.nix
  ];
  home.stateVersion = "24.11";
}
