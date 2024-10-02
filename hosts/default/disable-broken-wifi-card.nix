{
  # disable driver for broken internal wifi card
  # remove this module if your wifi card works fine
  boot.blacklistedKernelModules = [ "rtw88_8822ce" ];
}
