{ pkgs, ... }: {
  programs.librewolf = {
    enable = true;
    settings."widget.use-xdg-desktop-portal.file-picker" = 1;
  };

  # For stuff that I have to log into
  home.packages = with pkgs; [
    ungoogled-chromium
  ];
}
