{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza -la --icons=always";
      cat = "${pkgs.bat}/bin/bat -p";
      nuke = "set here $PWD; prevd; rm $here -rf";
      wget = "${pkgs.curl}/bin/curl -LOC -";
      lg = "${pkgs.lazygit}/bin/lazygit";
    };
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
          printf '\uf313  \u0000'
          set_color normal
        '';
      };
      fish_greeting.body = "";
    };
  };

  home.file.".config/kitty/kitty.conf".source = ./sources/kitty.conf;

  home.packages = with pkgs; [
    # fs tools
    broot
    file
    fd
    ouch

    # generate qr codes
    qrencode

    # json manipulation
    jq

    # build tools
    just

    # form over function (pretty tools)
    nitch

    kitty
  ];
}
