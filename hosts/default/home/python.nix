{ pkgs, ... }:
{
  home.packages = [
    pkgs.uv
    pkgs.ty
    (pkgs.python314.withPackages (
      ps: with ps; [
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
