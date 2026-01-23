{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./filesystem-hardening.nix
    ./phone-as-webcam.nix
    ./virtualization.nix
    ./desktops/kde.nix
    # ./sticky-keys.nix
    ./locale.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.nix-index-database.nixosModules.nix-index
    inputs.stylix.nixosModules.stylix
    # uni requires us to use uv for python
    # TODO: Restore binary isolation
    inputs.nix-ld.nixosModules.nix-ld
  ];

  boot = {
    # https://wiki.archlinux.org/title/Kernel_mode_setting#Early_KMS_start
    # early KMS over HDMI
    kernelParams = [
      "quiet"
      "splash"
      "video=HDMI-1:1920x1080@60"
    ];
    initrd.availableKernelModules = [ "i915" ];

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
  hardware.bluetooth.enable = true;

  powerManagement.powertop.enable = true;
  xdg.portal.enable = true;
  hardware.uinput.enable = true;
  services = {
    # sticky keys
    lollipop.enable = true;

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
    xserver = {
      enable = true;
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
  };

  documentation.man.generateCaches = false;

  environment.gnome.excludePackages = [ pkgs.gnome-keyring ];
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
    transmission_4-qt
    hashcat
  ];

  # Make sure opengl is enabled
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit =  true;
  hardware.graphics.extraPackages = with pkgs; [
    intel-compute-runtime
    intel-media-driver
    ocl-icd
    vulkan-headers
    vulkan-loader
    vulkan-validation-layers
    libva-vdpau-driver
    libvdpau-va-gl
    mesa
  ];

  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-116n.psf.gz";
    packages = with pkgs; [ terminus_font ];
    keyMap = "us";
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    nerd-fonts.terminess-ttf
  ];

  networking.firewall.enable = true;
  system.stateVersion = "24.05";
}
