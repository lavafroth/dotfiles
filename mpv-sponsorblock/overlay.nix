{ inputs, pkgs, ... }:
{
  nixpkgs.overlays = [
    (_: _: { sponsorblock-lib = inputs.mpv-sponsorblock.defaultPackage.x86_64-linux; })
  ];
}
