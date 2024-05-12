{ pkgs, ... }: {
  imports = [
    ../default/helix.nix
    ../default/shell.nix
  ];
  home.stateVersion = "23.11";
}
