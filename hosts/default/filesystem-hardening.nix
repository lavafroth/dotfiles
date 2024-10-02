{
  fileSystems = {
    "/root" = {
      device = "/root";
      options = [
        "bind"
        "nosuid"
        "noexec"
        "nodev"
      ];
    };

    "/var" = {
      device = "/var";
      options = [
        "bind"
        "nosuid"
        "noexec"
        "nodev"
      ];
    };

    "/etc" = {
      device = "/etc";
      options = [
        "bind"
        "nosuid"
        "nodev"
      ];
    };
  };
}
