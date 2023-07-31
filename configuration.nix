# Read the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./home.nix
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
      };
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
        "cloudflare"
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "exa -la";
      cat = "bat -p";
    };
  };

  users.users.h = {
    isNormalUser = true;
    description = "Himadri Bhattacharjee";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      bettercap
      blackbox-terminal
      cargo
      cargo-deny
      clippy
      du-dust
      dxvk
      fd
      feroxbuster
      ffmpeg
      ffuf
      file
      fragments
      gau
      gcc
      gh
      ghidra
      gimp
      git
      gnome.gnome-boxes
      gnome.gnome-tweaks
      gnome-secrets
      go
      gopls
      hashcat
      hcxtools
      hugo
      i2p
      jq  
      krita
      libreoffice-fresh
      librewolf
      libvirt
      lutris
      mariadb
      marksman
      neofetch
      nikto
      nmap
      onionshare
      patchelf
      picotool
      pkg-config
      pwntools
      python312
      qemu
      radare2
      rust-analyzer
      rustc
      rustfmt
      rustscan
      signal-desktop
      slides
      sqlmap
      tor-browser-bundle-bin
      vala-language-server
      wine
      yt-dlp
    ];
    shell = pkgs.fish;
  };

  # Enable experimental features for searching
  nix = {
   package = pkgs.nixFlakes;
   extraOptions = pkgs.lib.optionalString (config.nix.package == pkgs.nixFlakes)
     "experimental-features = nix-command flakes";
  };

  # I tried autoupgrade, didn't like it.
  # system.autoUpgrade.enable = true;

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
    gnome-tour
    gnome-text-editor
    gnome.geary
    gnome.yelp
    epiphany
  ];

  # Set the path for pkg-config to the openssl library
  # so that we may compile projects that link to openssl.
  # For example, a Rust project depending upon the openssl-sys crate.
  environment.variables = rec {
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    EDITOR = "${pkgs.helix}/bin/hx";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
    adw-gtk3
    aircrack-ng
    bat
    exa
    gnomeExtensions.blur-my-shell
    gnomeExtensions.quick-settings-tweaker
    gnomeExtensions.caffeine
    gnomeExtensions.rounded-window-corners
    helix
    hyperfine
    iw
    macchanger
    mpv
    ntfs3g
    openssl
    openssl.dev
    p7zip
    pciutils
    ripgrep
    tealdeer
    virtualenv # Needed for waydroid-scripts to enable libhoudini
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

    # Enable the nvidia settings menu
    # nvidiaSettings = true;

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Change this to upgrade to a later stateVersion.

}
