{ config, pkgs, ... }:

let githubHelper = "${pkgs.gh}/bin/gh auth git-credential"; in
{
  programs.git = {
    enable = true;
    userName = "Himadri Bhattacharjee";
    userEmail = "107522312+lavafroth@users.noreply.github.com";
    delta.enable = true;

    extraConfig = {
      credential."https://github.com".helper = githubHelper;
      credential."https://gist.github.com".helper = githubHelper;
      gpg.format = "ssh";
    };
    signing.signByDefault = true;
    signing.key = "${config.home.homeDirectory}/.ssh/id_ed25519";

  };
}
