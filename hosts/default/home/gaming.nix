{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dxvk
    wine64
    luanti
    (lutris.override {
      buildFHSEnv = args: pkgs.buildFHSEnv ( args // {
        multiPkgs = envPkgs: let
        originalPkgs = args.multiPkgs envPkgs;
        in builtins.filter (pkg: pkg.pname or "" != "openldap") originalPkgs;
      });
    })
  ];
}
