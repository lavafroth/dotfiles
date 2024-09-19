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
          set_color white
          printf '%s' $USER

          set_color red
          echo -ne ' at '
          set_color white
          printf '%s' (prompt_hostname)
          set_color red
          echo -ne ' in '

          set_color black -b red
          printf ' %s ' (prompt_pwd)
          set_color normal

          # Line 2
          echo
          set_color normal
          if test -n "$VIRTUAL_ENV"
              printf "(%s) " (set_color red)(basename $VIRTUAL_ENV)(set_color normal)
          end
          printf '\uf313  \u0000'
          set_color normal
        '';
      };
      fish_greeting.body = "";
    };
  };

  home.packages = with pkgs; [
    # fs tools
    broot
    file
    fd
    yazi
    ouch

    # generate qr codes
    qrencode

    # json manipulation
    jq

    # build tools
    just

    # form over function (pretty tools)
    nitch
  ];
}

