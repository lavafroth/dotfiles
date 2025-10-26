{ config, pkgs, ... }:

{
  programs = {

    gh = {
      enable = true;
      extensions = [
        (pkgs.stdenv.mkDerivation rec {
          name = "gh-star";
          pname = name;
          src = ./gh-extensions;
          installPhase = ''
            mkdir -p $out/bin
            cp $src/${name}.sh $out/bin/${name}
            chmod +x $out/bin/${name}
          '';
        })

        (pkgs.stdenv.mkDerivation rec {
          name = "gh-coauthor";
          pname = name;
          src = ./gh-extensions;
          installPhase = ''
            mkdir -p $out/bin
            cp $src/${name}.sh $out/bin/${name}
            chmod +x $out/bin/${name}
          '';
        })

        (pkgs.stdenv.mkDerivation rec {
          name = "gh-dependabot";
          pname = name;
          src = ./gh-extensions;
          installPhase = ''
            mkdir -p $out/bin
            cp $src/${name}.sh $out/bin/${name}
            chmod +x $out/bin/${name}
          '';
        })
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
