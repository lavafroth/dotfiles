{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Simply install just the packages
  environment.packages = with pkgs; [
    helix # or some other editor, e.g. nano or neovim
    ouch
    fd
    diffutils
    nh
    binutils
    coreutils
    gawk
    #tzdata
    hostname
    man
    git
    rage
    nerd-fonts.terminess-ttf
    ripgrep
    #gnugrep
    #gnupg
    gnused
    gnutar
    #bzip2
    #gzip
    #xz
    #zip
    #unzip
  ];

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  # Read the changelog before changing this value
  system.stateVersion = "23.11";

  # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  user.shell = "${pkgs.fish}/bin/fish";

  terminal.font = "${pkgs.nerd-fonts.terminess-ttf}/share/fonts/truetype/NerdFonts/TerminessNerdFont-Regular.ttf";
  # Set your time zone
  # time.timeZone = "Europe/Berlin";
  home-manager.config = ./home.nix;
}
