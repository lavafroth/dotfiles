{ pkgs, ... }:
{
  home.packages = with pkgs; [
    keepassxc
    kdePackages.kde-gtk-config
    kdePackages.kclock
    kdePackages.alligator
    kdePackages.karousel
    notify-desktop
    klassy
    (pkgs.writeShellScriptBin "kde-rotate" ''
      #!/usr/bin/env sh
      case $(${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor --json | ${pkgs.jq}/bin/jq .outputs[0].rotation) in
          1) direction=left ;;
          2) direction=inverted ;;
          4) direction=right ;;
          8) direction=none ;;
      esac
      ${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.eDP-1.rotation.$direction
    '')
  ];
  home.file.".config/kglobalshortcutsrc".source = ./sources/kglobalshortcutsrc;
  home.file.".config/kwinrc".source = ./sources/kwinrc;
}
