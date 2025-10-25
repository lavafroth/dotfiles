{ config, pkgs, ... }:

{
  programs = {

    gh = {
      enable = true;
      extensions = [
        (
          pkgs.stdenv.mkDerivation {
            pname = "gh-star";
            name = "gh-star";
            src = ./gh-star;
            installPhase = ''
              mkdir -p $out/bin
              cp $src/gh-star.sh $out/bin/gh-star
              chmod +x $out/bin/gh-star
            '';
          }
        )
      ];
    };
    git = {
      enable = true;
      settings = {
        user.name = "Himadri Bhattacharjee";
        user.email = "107522312+lavafroth@users.noreply.github.com";
        gpg.format = "ssh";
      };

      signing.signByDefault = true;
      signing.key = "${config.home.homeDirectory}/.ssh/id_ed25519";

    };

    delta.enable = true;
    jujutsu.enable = true;

  };
}
