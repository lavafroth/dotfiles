{ pkgs, ... }:
{
  # Make sure opengl is enabled
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.graphics.extraPackages = with pkgs; [
    intel-compute-runtime
    intel-media-driver
    ocl-icd
    vulkan-headers
    vulkan-loader
    vulkan-validation-layers
    libva-vdpau-driver
    libvdpau-va-gl
    mesa
  ];
}
