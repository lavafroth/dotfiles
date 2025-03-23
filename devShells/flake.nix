{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      forAllSystems =
        f:
        nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (system: f nixpkgs.legacyPackages.${system});
    in
    {

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
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
          ];
        };
      });
    };

}
