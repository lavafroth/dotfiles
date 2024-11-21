{ config, pkgs, ... }:
{
  home.packages = [
    pkgs.uv
    (pkgs.python312.withPackages (
      ps: with ps; [
        jupyter
        python-lsp-server
        python-lsp-ruff
        pandas
        requests
        xlrd
        xlwt
      ]
    ))
  ];
}
