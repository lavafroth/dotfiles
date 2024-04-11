# Tools for pentesting and playing CTFs
{ config, pkgs, ... }: {home.packages = with pkgs; [
  bettercap
  ffuf
  gau
  ghidra
  gitleaks
  hashcat
  hcxtools
  nikto
  nmap
  patchelf
  # pwntools
  feroxbuster
  rustscan
  sqlmap
  s3scanner
];}
