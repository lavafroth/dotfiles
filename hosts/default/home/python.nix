{ pkgs, ... }:
{
  home.packages = [
    pkgs.uv
    pkgs.ty
    (pkgs.python313.withPackages (
      ps: with ps; [
        marimo
        python-lsp-server
        python-lsp-ruff
        pandas
        httpx
        xlrd
        xlwt
        sympy
      ]
    ))
  ];
}
