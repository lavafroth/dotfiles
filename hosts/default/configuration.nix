{
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./disable-broken-wifi-card.nix
    ./filesystem-hardening.nix
    ./phone-as-webcam.nix
    ./nvidia.nix
    ./virtualization.nix
    # ./desktops/gnome.nix
    ./desktops/kde.nix
  ];

  boot = {
    kernelParams = [
      "quiet"
      "splash"
    ];
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
  };

  # fuck this shit chock full of memory leaks
  system.nssModules = pkgs.lib.mkForce [ ];
  # services.nscd.enableNsncd = false;
  # services.nscd.enable = false;

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
  hardware.uinput.enable = true;
  services = {
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
  };

  users.users.h = {
    isNormalUser = true;
    description = "Himadri Bhattacharjee";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
    ];
    packages = with pkgs; [
      i2p
      # libreoffice-fresh
      signal-desktop-bin
      tesseract
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

  services.ollama.enable = true;
  services.ollama.acceleration = "cuda";

  security = {
    rtkit.enable = true;
    sudo.enable = false;
    sudo-rs.enable = true;
    sudo-rs.execWheelOnly = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.variables = {
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    EDITOR = "${pkgs.helix}/bin/hx";
    QT_LOGGING_RULES = "kwin_*.debug=true";
  };

  documentation.man.generateCaches = false;

  environment.systemPackages = with pkgs; [
    bat
    git
    helix
    iw
    macchanger
    nh
    ntfs3g
    openvpn
    openssl
    pciutils
    picocom
    ripgrep
    sbctl
    wl-clipboard
    # android-studio
  ];

  # Make sure opengl is enabled
  hardware.graphics.enable = true;

  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-116n.psf.gz";
    packages = with pkgs; [ terminus_font ];
    keyMap = "us";
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    nerd-fonts.terminess-ttf
  ];
  networking.firewall.enable = true;
  system.stateVersion = "24.05";
}
