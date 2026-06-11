{ lib, ... }:
{
  security.sudo.enable = false;
  security.wrappers = {
    umount.setuid = lib.mkForce false;
    su.setuid = lib.mkForce false;
    sg.setuid = lib.mkForce false;
    pkexec.setuid = lib.mkForce false;
    passwd.setuid = lib.mkForce false;
    newuidmap.setuid = lib.mkForce false;
    newgrp.setuid = lib.mkForce false;
    newgidmap.setuid = lib.mkForce false;
    mount.setuid = lib.mkForce false;
    fusermount3.setuid = lib.mkForce false;
    fusermount.setuid = lib.mkForce false;
    chsh.setuid = lib.mkForce false;
  };
}
