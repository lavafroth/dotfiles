{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./bootloader.nix
    ./hardware-configuration.nix
    ./desktops/kde.nix
    ./locale.nix
    ./disable-setuid.nix
    ./graphics.nix
    ./idevice.nix
    # ./phone-as-webcam.nix
    # ./virtualization.nix
    ./ydotool.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.nix-index-database.nixosModules.nix-index
    inputs.stylix.nixosModules.stylix
    inputs.nix-ld.nixosModules.nix-ld # TODO: Restore binary isolation
  ];

  boot.extraModprobeConfig = ''
    install algif_aead ${pkgs.busybox}/bin/false
    install esp4 ${pkgs.busybox}/bin/false
    install esp6 ${pkgs.busybox}/bin/false
    install rxrpc ${pkgs.busybox}/bin/false

  '';
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.h = import ./home;

  # Enable networking
  networking = {
    hostName = "cafe";
    networkmanager.enable = true;
  };
  hardware.bluetooth.enable = true;

  powerManagement.powertop.enable = true;
  hardware.uinput.enable = true;

  xdg.portal.extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
  xdg.portal.enable = true;

  services = {
    # sticky keys
    lollipop.enable = true;
    lollipop.timeout = 300;
    lollipop.touchpad.enable = true;
    lollipop.touchpad.timeout = 300;
    lollipop.sharedMemory = true;

    # dbus broker is faster
    dbus.implementation = "broker";

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable sound with pipewire.
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # X11
    xserver.enable = false;
    displayManager.autoLogin = {
      enable = true;
      user = "h";
    };
  };

  users.users.h = {
    isNormalUser = true;
    description = "Himadri Bhattacharjee";
    extraGroups = [
      "networkmanager"
      "wheel"
      "uinput"
      "libvirtd"
      "dialout" # for accessing arduinos and other serial devices
    ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
  programs.nix-ld.dev.enable = true;
  programs.nix-ld.libraries = [
    pkgs.stdenv.cc.cc.lib
  ];

  # Enable nix-command for search and flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.use-xdg-base-directories = true;
  programs.nix-index-database.comma.enable = true;

  security.rtkit.enable = true;
  nixpkgs.config.allowUnfree = true;

  environment.variables = {
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    EDITOR = "${pkgs.helix}/bin/hx";
  };

  documentation.man.cache.enable = false;

  environment.gnome.excludePackages = [ pkgs.gnome-keyring ];
  environment.systemPackages = with pkgs; [
    bat
    git
    helix
    iw
    wifite2
    macchanger
    nh
    ntfs3g
    openvpn
    openssl
    pciutils
    picocom
    ripgrep
    wl-clipboard
    transmission_4-qt
    hashcat
  ];

  console = {
    earlySetup = true;
    font = "ter-v16n";
    packages = with pkgs; [ terminus_font ];
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    nerd-fonts.terminess-ttf
  ];

  networking.firewall.enable = true;

  system.stateVersion = "26.05";
}
