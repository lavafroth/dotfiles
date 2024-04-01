# Tools for pentesting and playing CTFs
{ pkgs, ... }: with pkgs; [
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
  rustscan
  sqlmap
  s3scanner
]
