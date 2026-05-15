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
    # ./phone-as-webcam.nix
    # ./virtualization.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.nix-index-database.nixosModules.nix-index
    inputs.stylix.nixosModules.stylix
    # uni requires uv for python
    # TODO: Restore binary isolation
    inputs.nix-ld.nixosModules.nix-ld
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
    wireless.iwd.enable = true;
    wireless.iwd.settings.Settings.AddressRandomization = "network";
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
  security.sudo.enable = false;
  security.wrappers = {
    umount.setuid = pkgs.lib.mkForce false;
    su.setuid = pkgs.lib.mkForce false;
    sg.setuid = pkgs.lib.mkForce false;
    pkexec.setuid = pkgs.lib.mkForce false;
    passwd.setuid = pkgs.lib.mkForce false;
    newuidmap.setuid = pkgs.lib.mkForce false;
    newgrp.setuid = pkgs.lib.mkForce false;
    newgidmap.setuid = pkgs.lib.mkForce false;
    mount.setuid = pkgs.lib.mkForce false;
    fusermount3.setuid = pkgs.lib.mkForce false;
    fusermount.setuid = pkgs.lib.mkForce false;
    chsh.setuid = pkgs.lib.mkForce false;
  };

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
  hardware.graphics.enable32Bit = true;
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
    font = "ter-v16n";
    packages = with pkgs; [ terminus_font ];
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    nerd-fonts.terminess-ttf
  ];

  networking.firewall.enable = true;

  system.stateVersion = "24.05";
}
