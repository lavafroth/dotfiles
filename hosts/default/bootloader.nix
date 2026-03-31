{
  boot = {
    # https://wiki.archlinux.org/title/Kernel_mode_setting#Early_KMS_start
    # early KMS over HDMI
    kernelParams = [
      "quiet"
      "splash"
      "video=HDMI-1:1920x1080@60"
    ];
    initrd.availableKernelModules = [ "i915" ];

    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
      };
      efi.canTouchEfiVariables = true;
    };
    initrd.systemd.enable = true;
  };
}
