# Read the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./gnome-extensions.nix
    ];

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    # no keyfile
    initrd.secrets."/crypto_keyfile.bin" = null;
  };

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking = {
    hostName = "cafe";
    networkmanager.enable = true;
    nameservers = [ "127.0.0.1" "::1" ];
    # If using dhcpcd:
    # dhcpcd.extraConfig = "nohook resolv.conf";
    # If using NetworkManager:
    networkmanager.dns = "none";
  };

  services.jackett = {
    enable = true;
    user = "h";
  };

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

      # You can choose a specific set of servers from https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
      server_names = [
        "dnsforge.de"
        "nextdns"
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
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services = {
    flatpak.enable = true;
    # Enable CUPS to print documents.
    printing.enable = true;
    # Enable sound with pipewire.
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    xserver = {
      # Enable the X11 windowing system.
      enable = true;

      # Enable the GNOME Desktop Environment.
      desktopManager.gnome.enable = true;

      # Configure keymap in X11
      layout = "us";
      xkbVariant = "";

      displayManager = {
        gdm.enable = true;
        autoLogin.enable = true;
        autoLogin.user = "h";
      };
      excludePackages = [ pkgs.xterm ];
      desktopManager.xterm.enable = false;
      # Tell Xorg to use the nvidia driver
      videoDrivers = ["nvidia"];
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza -la";
      cat = "bat -p";
    };
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.h = {
    isNormalUser = true;
    description = "Himadri Bhattacharjee";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs;
      let pythonPackages = python311.withPackages(ps: with ps; [
        jupyter
        pandas
        requests
        xlrd
        xlwt
      ]);
      in [
      bettercap
      blackbox-terminal
      broot
      cargo
      cargo-deny
      clippy
      delta
      dxvk
      fd
      feroxbuster
      ffmpeg
      ffuf
      file
      gau
      gcc
      gh
      ghidra
      gimp
      gnome.gnome-boxes
      gnome.gnome-tweaks
      gnome-secrets
      go
      gopls
      hashcat
      hcxtools
      hugo
      hyperfine
      i2p
      jq
      krita
      lazygit
      libreoffice-fresh
      librewolf
      libvirt
      linuxPackages_latest.perf
      lutris
      mariadb
      marksman
      neofetch
      nil
      nikto
      nmap
      onionshare
      patchelf
      picotool
      pkg-config
      pwntools
      pythonPackages
      qemu
      qrencode
      radare2
      rust-analyzer
      rustc
      rustfmt
      rustscan
      # signal-desktop
      slides
      sbctl
      sqlmap
      tor-browser-bundle-bin
      unrar
      wine
      yt-dlp
    ];
    shell = pkgs.fish;
  };

  # Enable nix-command for search and flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.autoUpgrade.enable = false;

  # Replace sudo with doas
  security = {
    rtkit.enable = true;
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [{
        groups = [ "wheel" ];
        persist = false;
        keepEnv = true;
      }];
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
    gnome-photos
  ];

  environment.variables = rec {
    # Set the path for pkg-config to the openssl library
    # so that we may compile projects that link to openssl.
    # For example, a Rust project depending upon the openssl-sys crate.
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    EDITOR = "${pkgs.helix}/bin/hx";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
    adw-gtk3
    aircrack-ng
    bat
    eza
    git
    helix
    iw
    macchanger
    mpv
    ntfs3g
    openssl
    openssl.dev
    p7zip
    pciutils
    picocom
    ripgrep
    tealdeer
    wget
    wifite2
    wl-clipboard
    (writeScriptBin "sudo" ''exec doas "$@"'')
  ];

  # Make sure opengl is enabled
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # NVIDIA drivers are unfree.
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "nvidia-x11"
    ];


  # Enable syncthing to sync books,
  # captured photos and videos with my phone.
  services.syncthing = {
    enable = true;
    user = "h";
    dataDir = "/home/h/Sync";
    configDir = "/home/h/.config/syncthing";
  };

  hardware.nvidia = {

    # Modesetting is needed for most wayland compositors
    modesetting.enable = true;

    # Use the open source version of the kernel module
    # Only available on driver 515.43.04+
    open = true;

    # Disable the nvidia settings menu
    nvidiaSettings = false;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Enable waydroid to run android applications in a sandbox
  virtualisation = {
    waydroid.enable = true;
    lxd.enable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;
  system.stateVersion = "23.11"; # Change this to upgrade to a later stateVersion.
}
