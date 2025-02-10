{
  pkgs,
  ...
}:

{
  environment.packages = with pkgs; [
    ouch
    fd
    diffutils
    binutils
    coreutils
    #tzdata
    hostname
    man
    gitMinimal
    rage
    nerd-fonts.terminess-ttf
    ripgrep
    gnused
    gnutar
    mdcat
    openssh
    yt-dlp
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
