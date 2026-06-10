{ pkgs, ... }:
{
  security.sudo.enable = false;
  security.wrappers = {
    umount.setuid = pkgs.lib.mkForce false;
    su.setuid = pkgs.lib.mkForce false;
    sg.setuid = pkgs.lib.mkForce false;
    pkexec.setuid = pkgs.lib.mkForce false;
    passwd.setuid = pkgs.lib.mkForce false;
    newuidmap.setuid = pkgs.lib.mkForce false;
    newgrp.setuid = pkgs.lib.mkForce false;
    newgidmap.setuid = pkgs.lib.mkForce false;
    mount.setuid = pkgs.lib.mkForce false;
    fusermount3.setuid = pkgs.lib.mkForce false;
    fusermount.setuid = pkgs.lib.mkForce false;
    chsh.setuid = pkgs.lib.mkForce false;
  };
}
