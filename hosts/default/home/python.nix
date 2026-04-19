{ pkgs, ... }:
{
  home.packages = [
    pkgs.uv
    pkgs.ty
    pkgs.ruff
    (pkgs.python313.withPackages (
      ps: with ps; [
        marimo
        python-lsp-server
        pandas
        httpx
        xlrd
        xlwt
        sympy
      ]
    ))
  ];
}
