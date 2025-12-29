{
  description = "matplotlib kitcat devshell";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

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
          packages = [
            (pkgs.python313.withPackages (
              ps: with ps; [
                numpy
                matplotlib
                pandas
                scikit-learn
                seaborn
                # kitkat backend to view plots
                # directly in the kitty terminal
                (ps.buildPythonPackage rec {
                  pname = "kitcat";
                  version = "1.2.1";
                  format = "pyproject";
                  src = pkgs.fetchPypi {
                    inherit pname version;
                    hash = "sha256-biNvOgAtSUUxvDtBH78Z6MG/pq9rhles3DDvokbpLsg=";
                  };
                  nativeBuildInputs = with ps; [ hatchling ];
                  buildInputs = with ps; [
                    matplotlib
                    setuptools
                  ];
                })
              ]
            ))
          ];

          MPLBACKEND = "kitcat";
          PYTHONSTARTUP = "${pkgs.writeText "pythonstartup.py" ''
            import numpy as np
            import pandas as pd
            import torch
            from torch import nn
            ''}";
        };
      });
    };
}
