{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./disable-broken-wifi-card.nix
    ./filesystem-hardening.nix
    ./phone-as-webcam.nix
    ./nvidia.nix
    ./secure-dns.nix
    ./virtualization.nix
    ./desktops/gnome.nix
    # ./desktops/kde.nix
  ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
      };
      efi.canTouchEfiVariables = true;
    };
    initrd.systemd.enable = true;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.h = import ./home;

  # Enable networking
  networking = {
    hostName = "cafe";
    networkmanager.enable = true;
    nameservers = [
      "127.0.0.1"
      "::1"
    ];
    networkmanager.dns = "none";
  };

  services.fwupd.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  powerManagement.powertop.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  xdg.portal.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.uinput.enable = true;
  services = {

    # dbus broker is faster
    dbus.implementation = "broker";

    # Enable CUPS to print documents.
    printing.enable = true;
    # Enable sound with pipewire.
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    xserver = {
      # Enable the X11 windowing system.
      enable = true;

      # Configure keymap in X11
      xkb.layout = "us";
      xkb.variant = "";

      excludePackages = [ pkgs.xterm ];
      desktopManager.xterm.enable = false;
    };

    displayManager.autoLogin = {
      enable = true;
      user = "h";
    };
    # desktopManager.cosmic.enable = true;
    # displayManager.cosmic-greeter.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  users.users.h = {
    isNormalUser = true;
    description = "Himadri Bhattacharjee";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
    ];
    packages = with pkgs; [
      ttyper
      i2p
      libreoffice-fresh
      openvpn
      signal-desktop
    ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  # Enable nix-command for search and flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.autoUpgrade.enable = false;

  system.switch = {
    enable = false;
    enableNg = true;
  };

  # Replace sudo with sudo-rs
  security = {
    rtkit.enable = true;
    sudo.enable = false;
    sudo-rs = {
      enable = true;
      execWheelOnly = true;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.plasma6.excludePackages = with pkgs; [
    konsole
  ];
  environment.variables = {
    # Set the path for pkg-config. Mostly for CFFI projects.
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    EDITOR = "${pkgs.helix}/bin/hx";
  };

  environment.systemPackages = with pkgs; [
    aircrack-ng
    bat
    git
    gnupg
    helix
    iw
    macchanger
    nh
    ntfs3g
    openssl
    pciutils
    picocom
    ripgrep
    sbctl
    wifite2
    wl-clipboard
    libnotify
  ];

  # Make sure opengl is enabled
  hardware.graphics.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    terminus-nerdfont
    monaspace
  ];
  networking.firewall.enable = true;
  system.stateVersion = "24.05";
}
