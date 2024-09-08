{ pkgs, ... }: {
  programs.librewolf = {
    enable = true;
    settings = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
      "browser.sessionstore.resume_from_crash" = false;
    };
  };

  home.packages = with pkgs; [
    ungoogled-chromium
    tor-browser-bundle-bin
  ];
}
