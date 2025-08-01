{
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  sops.defaultSopsFile = ./secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/user/.config/sops/age/keys.txt";
  sops.secrets.wireless_ap = { };
  sops.secrets.copyparty_himadri = {
    owner = "copyparty";
  };
  sops.secrets.copyparty_sampurna = {
    owner = "copyparty";
  };
  sops.secrets.transmission = {
    owner = "transmission";
    restartUnits = [ "transmission.service" ];
  };

  services.immich.enable = true;
  services.immich.port = 2283;
  services.immich.openFirewall = true;
  services.immich.host = "0.0.0.0";
  services.immich.accelerationDevices = null;

  users.users.immich.extraGroups = [
    "video"
    "render"
  ];

  services.copyparty = {
    enable = true;
    # directly maps to values in the [global] section of the copyparty config.
    # see `copyparty --help` for available options
    settings = {
      i = "0.0.0.0";
      p = 3210;
      # using 'false' will do nothing and omit the value when generating a config
      ignored-flag = false;
    };

    # create users
    accounts = {
      himadri.passwordFile = "/run/secrets/copyparty_himadri";
      sampurna.passwordFile = "/run/secrets/copyparty_sampurna";
    };

    # create a volume
    volumes = {
      # create a volume at "/" (the webroot), which will
      "/" = {
        path = "/media/ssd0";
        access = {
          rwmda = "himadri";
        };
        flags = {
          fk = 4;
          scan = 60;
          e2d = true;
        };
      };

      "/Music" = {
        path = "/media/ssd0/Stasis/Music";
        access.r = "*";
        flags.e2d = true;
      };

      "/Movies" = {
        path = "/media/ssd0/Stasis/Movies";
        access.r = "*";
        flags.e2d = true;
      };
    };
    # you may increase the open file limit for the process
    openFilesLimit = 8192;
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.timeout = 1;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "rahu";
  networking.networkmanager.enable = true;

  # Time zone and locale.
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";

  services.transmission = {
    package = pkgs.transmission_4;
    enable = true;
    openRPCPort = true;
    settings = {
      rpc-bind-address = "0.0.0.0";
      # Allow connections from localhost and LAN
      rpc-whitelist = "127.0.0.1,192.168.12.*";
      rpc-authentication-required = true;
      download-dir = "/media/seed";
      encryption = 2;
      peer-limit = 2000;
      peer-limit-global = 2000;
      peer-limit-per-torrent = 500;
    };
    credentialsFile = "/run/secrets/transmission";
  };

  systemd.services.transmission.serviceConfig.BindPaths = [
    "/media/ssd0/Stasis/Games"
    "/media/ssd0/Stasis/Movies"
    "/media/ssd0/Stasis/Books"
  ];

  systemd.services.create_ap = {
    enable = true;
    description = "Create AP Service";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.linux-wifi-hotspot}/bin/create_ap --config /run/secrets/wireless_ap";
      KillSignal = "SIGINT";
      Restart = "on-failure";
    };
  };

  systemd.services.homage = {
    enable = true;
    description = "Homeage homepage";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      ExecStart = "/home/user/local/homage /home/user/local/config.txt";
      Environment = "PATH=/run/current-system/sw/bin/";
    };
  };

  programs.fish.enable = true;

  systemd.tmpfiles.rules = [
    "d /media 1777 root root"
    "d /media/seed 1777 transmission transmission"
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 112d";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA/wbGoIUsbBHFbnXj2g+23C8sUgYkZTq0TrBm0MMWnx"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICy8DNUvVXhXhqNaEHfcUJdSY5ZS1cn9roLHQF/pQUO0"
    ];
    packages = with pkgs; [
      ripgrep
      nh
    ];

    shell = pkgs.fish;
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    git
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    wget
    helix
    acpi
  ];

  services.openssh = {
    enable = true;
    settings = {
      AllowUsers = [ "user" ];
      PasswordAuthentication = false;
      X11Forwarding = false;
    };
  };
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
  networking.firewall.allowedTCPPorts = [
    2342
    3210
    80
  ];
  system.stateVersion = "23.11";
}
