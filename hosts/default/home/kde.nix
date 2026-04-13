{ pkgs, ... }:
{
  home.packages = with pkgs; [
    keepassxc
    haruna
    kdePackages.kde-gtk-config
    kdePackages.kclock
    kdePackages.alligator
    kdePackages.karousel
    notify-desktop
    klassy

    (pkgs.writeShellScriptBin "rotate-screen" ''
      #!/usr/bin/env sh
      case $(${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor --json | ${pkgs.jq}/bin/jq .outputs[0].rotation) in
          1) direction=left ;;
          2) direction=inverted ;;
          4) direction=right ;;
          8) direction=none ;;
      esac
      ${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.eDP-1.rotation.$direction
    '')

    (pkgs.writeShellScriptBin "toggle-touchpad" ''
      touchpad=$(awk '$0 ~ /touchpad/I { split(FILENAME, path, "/") } END { print path[5] }' /sys/class/input/event*/device/name)
      device=/org/kde/KWin/InputDevice/$touchpad
      get_property=org.freedesktop.DBus.Properties.Get
      interface=org.kde.KWin.InputDevice
      if test $(qdbus org.kde.KWin $device $get_property $interface enabled) = true; then
        toggle=false
      else
        toggle=true
      fi

      qdbus org.kde.KWin $device $interface.enabled $toggle
    '')
  ];
  home.file.".config/kglobalshortcutsrc".source = ./sources/kglobalshortcutsrc;
  home.file.".config/kwinrc".source = ./sources/kwinrc;
}
