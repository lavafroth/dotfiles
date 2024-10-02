{pkgs, ...}: {
  boot = {
    extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];
    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 card_label="Virtual Webcam"
    '';
    kernelModules = [ "v4l2loopback" ];
  };

  environment.systemPackages = [
    (pkgs.writeScriptBin "phone-webcam" ''
      ${pkgs.android-tools}/bin/adb start-server
      ${pkgs.android-tools}/bin/adb devices
      ${pkgs.scrcpy}/bin/scrcpy --video-source=camera --no-audio --camera-facing=back --v4l2-sink=/dev/video0 -m1024
    '')
  ];
}
