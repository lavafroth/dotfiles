{ inputs, config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.timeout = 1;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "rahu"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Time zone and locale.
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";

  services.transmission = {
    enable = true;
    openRPCPort = true;
    settings = {
      rpc-bind-address = "0.0.0.0";
      download-dir = "/media/seed";
      encryption = 2;
      peer-limit = 2000;
      peer-limit-global = 2000;
      peer-limit-per-torrent = 500;
    };
  };

  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    packages = with pkgs; [ terminus_font ];
    keyMap = "us";
  };

  services.samba = {
    enable = true;
    openFirewall = true;
    securityType = "user";
    extraConfig = ''
      security = user
      guest account = nobody
      map to guest = bad user
    '';
    shares = {
      media = {
        path = "/media";
        "valid users" = "user";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "writable" = "true";
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d /media 1777 root root"
    "d /media/seed 1777 transmission transmission"
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # system.autoUpgrade.enable = true;
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
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs;
      let
        transmission-compose = (pkgs.callPackage
          (fetchFromGitHub {
            owner = "lavafroth";
            repo = "transmission-compose";
            rev = "983355f668a0b230af17ff4dba4311f4b58c21d6";
            sha256 = "sha256-mJcFA5Q+6ZuFgKSG78aCpoHtMRBqid03Qr7guGw7ui8=";
          })
          { });
      in
      [ transmission-compose ];
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    wget
    helix
    acpi
  ];

  services.openssh.enable = true;
  services = {
    syncthing = {
      enable = true;
      user = "user";
      dataDir = "/home/user/"; # Default folder for new synced folders
      configDir = "/home/user/.config/syncthing"; # Folder for Syncthing's settings and ke
      guiAddress = "0.0.0.0:8384";
    };
    jellyfin = {
      enable = true;
      openFirewall = true;
    };
  };
  networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];
  system.stateVersion = "23.11";
}
