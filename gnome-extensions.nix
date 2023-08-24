{ config, pkgs, ... }:

{
  config.environment.systemPackages = with pkgs.gnomeExtensions; [
    blur-my-shell
    quick-settings-tweaker
    user-themes
    caffeine
    rounded-window-corners
  ];
}
