{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelModules = [ "v4l2loopback" "nvidia_uvm" ];
    extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];
    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 card_label="Virtual Webcam"
    '';
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.h = import ./home.nix;

  # Enable networking
  networking = {
    hostName = "cafe";
    networkmanager.enable = true;
    nameservers = [ "127.0.0.1" "::1" ];
    networkmanager.dns = "none";
  };

  services.fwupd.enable = true;
  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      ipv6_servers = true;
      require_dnssec = true;

      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };

      # You can choose a specific set of servers from
      # https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
      server_names = [
        "dnsforge.de"
        "mullvad-adblock-doh"
      ];
    };
  };

  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = "dnscrypt-proxy";
  };

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
      videoDrivers = [ "nvidia" ];
    };

    displayManager.autoLogin = {
      enable = true;
      user = "h";
    };
    # desktopManager.cosmic.enable = true;
    # displayManager.cosmic-greeter.enable = true;
    displayManager.sddm = { enable = true; wayland.enable = true; };

    # Enable the Plasma.
    desktopManager.plasma6.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  users.users.h = {
    isNormalUser = true;
    description = "Himadri Bhattacharjee";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [
      ags
      broot
      fd
      ffmpeg-full
      file
      gnome.gnome-boxes
      go
      gopls
      i2p
      jellyfin-media-player
      jq
      just
      kdenlive
      libreoffice-fresh
      mpv
      nil
      nitch
      ouch
      openvpn
      qrencode
      signal-desktop
      tor-browser-bundle-bin
      tenacity
      virt-manager
      yazi
      yt-dlp
      zellij
    ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          (pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd
        ];
      };
    };
  };

  # Enable nix-command for search and flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.autoUpgrade.enable = false;

  # Replace sudo with sudo-rs
  security = {
    rtkit.enable = true;
    sudo.enable = false;
    sudo-rs = {
      enable = true;
      execWheelOnly = true;
    };
  };

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.gnome.excludePackages = with pkgs; [
    epiphany
    gnome.geary
    gnome-text-editor
    gnome-tour
    gnome.yelp
    gnome.totem
  ];

  environment.variables = {
    # Set the path for pkg-config. Mostly for CFFI projects.
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    EDITOR = "${pkgs.helix}/bin/hx";
  };

  # `nix search package` to search for a package
  environment.systemPackages = with pkgs; [
    adw-gtk3
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
    kdePackages.sddm-kcm
    libnotify
    (pkgs.runCommand "gpu-screen-recorder-gtk"
      {
        nativeBuildInputs = [ pkgs.makeWrapper ];
      } ''
      mkdir -p $out/bin
      makeWrapper ${pkgs.gpu-screen-recorder-gtk}/bin/gpu-screen-recorder-gtk $out/bin/gpu-screen-recorder-gtk \
        --prefix LD_LIBRARY_PATH : ${pkgs.libglvnd}/lib \
        --prefix LD_LIBRARY_PATH : ${config.boot.kernelPackages.nvidia_x11}/lib
    '')
  ];

  # Make sure opengl is enabled
  hardware.graphics.enable = true;

  # NVIDIA drivers are unfree.
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "nvidia-x11"
    ];


  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    terminus-nerdfont
  ];

  hardware.nvidia = {

    # Modesetting is needed for most wayland compositors
    modesetting.enable = true;

    # I use proprietary CUDA garbage with direnv on a
    # per-directory basis. So should you.
    open = true;

    # Disable the nvidia settings menu
    nvidiaSettings = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Enable waydroid to run android applications in a sandbox
  # virtualisation = {
  #   waydroid.enable = true;
  #   lxd.enable = true;
  # };
  virtualisation.podman.enable = true;

  networking.firewall.enable = true;
  system.stateVersion = "24.05";
}
