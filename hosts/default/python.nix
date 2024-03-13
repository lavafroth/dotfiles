{ pkgs, ... }:
pkgs.python311.withPackages (ps: with ps; [
  jupyter
  python-lsp-server
  python-lsp-ruff
  pandas
  requests
  xlrd
  xlwt
])
