{ pkgs, ... }: {
  systemd.user.services.ags-hud = {
    Unit = {
      Description = "ags cyberpunk hud for my cosmic epoch setup";
    };
    Install.WantedBy = [ "xdg-desktop-autostart.target" ];
    Service = {
      ExecStart = "${pkgs.ags}/bin/ags";
    };
  };
}
