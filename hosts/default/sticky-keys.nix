{
  services.keyd = {
    enable = true;
    keyboards.sticky_keys.settings = {
      global.layer_indicator = true;
      main = {
        control = "oneshot(control)";
        meta = "oneshot(meta)";
        shift = "oneshot(shift)";
        leftalt = "oneshot(alt)";
      };

      control = {
        control = "toggle(control)";
        capslock = "clear()";
      };

      meta = {
        meta = "toggle(meta)";
        capslock = "clear()";
      };

      shift = {
        shift = "toggle(shift)";
        capslock = "clear()";
      };

      alt = {
        leftalt = "toggle(alt)";
        capslock = "clear()";
      };

    };
  };
}
