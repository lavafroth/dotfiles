{ pkgs, ... }:
{
  systemd.user.services.ydotool = {
    description = "ydotoold user service";
    wantedBy = [ "default.target" ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.ydotool}/bin/ydotoold";
      Restart = "on-failure";
    };
  };
}
