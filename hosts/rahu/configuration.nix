{
  inputs,
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
  sops.secrets.photoprism_password = { };
  sops.secrets.wireless_ap = { };

  services.photoprism = {
    enable = true;
    originalsPath = "/media/Himadri/Stasis/Camera";
    address = "0.0.0.0";
    passwordFile = "/run/secrets/photoprism_password";
    settings = {
      PHOTOPRISM_ADMIN_USER = "user";
    };
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
      download-dir = "/media/seed";
      encryption = 2;
      peer-limit = 2000;
      peer-limit-global = 2000;
      peer-limit-per-torrent = 500;
    };
  };

  systemd.services.create_ap = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    description = "Create AP Service";
    after = [ "network.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.linux-wifi-hotspot}/bin/create_ap --config /run/secrets/wireless_ap";
      KillSignal = "SIGINT";
      Restart = "on-failure";
    };
  };

  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    packages = with pkgs; [ terminus_font ];
    keyMap = "us";
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
    options = "--delete-older-than 14d";
  };

  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "--no-write-lock-file"
      "-L"
    ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages =
      with pkgs;
      let
        transmission-compose = (
          stdenv.mkDerivation {
            name = "transmission-compose";
            src = fetchurl {
              url = "https://github.com/lavafroth/transmission-compose/releases/download/1.1.1/transmission-compose_1.1.1_x86_64-unknown-linux-musl.tar.zst";
              sha256 = "319531358cccc35bc3aa8a61d7d691e7e3fd22ac8e1a08b66ef3399a9d84ed67";
            };
            phases = [
              "installPhase"
              "patchPhase"
            ];
            buildInputs = [ zstd ];
            installPhase = ''
              mkdir -p $out/bin
              tar --extract --directory $out/bin --file $src transmission-compose
              chmod +x $out/bin/transmission-compose
            '';
          }
        );
      in
      [
        transmission-compose
        ripgrep
        jq
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

  services.openssh.enable = true;
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
  networking.firewall.allowedTCPPorts = [ 2342 ];
  system.stateVersion = "23.11";
}
