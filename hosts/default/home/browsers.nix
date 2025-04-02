{ pkgs, ... }:
{
  programs.librewolf = {
    enable = true;
    settings = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
      "browser.sessionstore.resume_from_crash" = false;
    };
  };

  home.packages = with pkgs; [
    arti
    ungoogled-chromium
    # chromium recently messed up with pipewire stuff and rendered screen share unusable
    # hence brave for the time being
    brave
  ];
}
