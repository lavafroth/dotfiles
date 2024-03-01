{ config, pkgs, ... }:

let githubHelper = "${pkgs.gh}/bin/gh auth git-credential"; in
{

  imports = [ ./gnome.nix ];

  home = {
    file = {
      ".config/helix/config.toml".source = ./sources/helix/config.toml;
      ".config/mpv" = {
          source = ./sources/mpv;
          recursive = true;
        };
      # Do not display fish in the menu
      ".local/share/applications/fish.desktop".source = ./sources/fish.desktop;
    };

    sessionVariables = {
      GOPATH = "${config.home.homeDirectory}/Public/go";
      GOBIN = "${config.home.sessionVariables.GOPATH}/bin";
    };


    sessionPath = [ config.home.sessionVariables.GOBIN "${config.home.homeDirectory}/.cargo/bin" ];

    stateVersion = "24.05";
  };

  xdg.desktopEntries.ocr = {
    name = "Screen Grab OCR";
    exec = "${pkgs.writeScript "ocr" ''
      ${pkgs.gnome.gnome-screenshot}/bin/gnome-screenshot --area --file /tmp/ocr-tmp.png
      ${pkgs.tesseract}/bin/tesseract /tmp/ocr-tmp.png - | ${pkgs.wl-clipboard}/bin/wl-copy
      rm /tmp/ocr-tmp.png
    ''}";
  };

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
  programs.fish = {
    enable = true;
    functions = {
      fish_prompt = {
        body = ''
        if not set -q VIRTUAL_ENV_DISABLE_PROMPT
            set -g VIRTUAL_ENV_DISABLE_PROMPT true
        end
        set_color yellow
        printf '%s' $USER
        set_color normal
        printf ' at '

        set_color magenta
        echo -n (prompt_hostname)
        set_color normal
        printf ' in '

        set_color $fish_color_cwd
        printf '%s' (prompt_pwd)
        set_color normal

        # Line 2
        echo
        if test -n "$VIRTUAL_ENV"
            printf "(%s) " (set_color blue)(basename $VIRTUAL_ENV)(set_color normal)
        end
        printf '↪ '
        set_color normal
        '';
      };
      fish_greeting.body = "";
    };
  };
}
