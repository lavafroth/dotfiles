{config, pkgs, ...} :{
    boot.kernelModules = [ "nvidia_uvm" ];
    hardware.nvidia = {

      # Modesetting is needed for most wayland compositors
      modesetting.enable = true;

      # I use proprietary CUDA garbage with direnv on a
      # per-directory basis. So should you.
      open = true;

      # Disable the nvidia settings menu
      nvidiaSettings = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    # NVIDIA drivers are unfree.
    nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "nvidia-x11"
    ];

    services.xserver.videoDrivers = [ "nvidia" ];

    # GPU screen recorder: akin to shadowplay on windows
    environment.systemPackages = with pkgs; [
      (runCommand "gpu-screen-recorder-gtk"
        {
          nativeBuildInputs = [ pkgs.makeWrapper ];
        } ''
        mkdir -p $out/bin
        makeWrapper ${pkgs.gpu-screen-recorder-gtk}/bin/gpu-screen-recorder-gtk $out/bin/gpu-screen-recorder-gtk \
          --prefix LD_LIBRARY_PATH : ${pkgs.libglvnd}/lib \
          --prefix LD_LIBRARY_PATH : ${config.boot.kernelPackages.nvidia_x11}/lib
      '')
    ];
}
