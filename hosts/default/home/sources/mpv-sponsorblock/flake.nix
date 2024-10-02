{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    naersk.url = "github:nix-community/naersk";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    mpv-sponsorblock = {
      url = "github:TheCactusVert/mpv-sponsorblock";
      flake = false;
    };
  };

  outputs = { self, flake-utils, naersk, mpv-sponsorblock, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        naersk' =
          (import nixpkgs) {
            inherit system;
          }.callPackage
            naersk
            { };

      in
      {
        # For `nix build` & `nix run`:
        defaultPackage = naersk'.buildPackage {
          src = mpv-sponsorblock;
          copyLibs = true;
          copyBins = false;
          release = true;
        };
      }
    );
}
