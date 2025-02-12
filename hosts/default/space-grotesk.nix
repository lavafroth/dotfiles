{
  lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation {
  pname = "space-grotesk";
  version = "2.0";

  src = fetchFromGitHub {
    owner = "floriankarsten";
    repo = "space-grotesk";
    rev = "03507d024a01282884232081fc6011c09ff4e849";
    hash = "sha256-NvDJeIJYGn3sNGGuOLYz9jQf/NKvt8jsZdhwsliHzzM=";
  };

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp -a fonts/ttf/static/*.ttf $out/share/fonts/truetype/
  '';

  outputHashAlgo = "sha256";
  outputHashMode = "recursive";
  outputHash = "J5c2KyhNnnqtjKAbUTsLVEUgsVkGXfzWD+0h0tIMdsk=";

  meta = with lib; {
    homepage = "https://floriankarsten.github.io/space-grotesk";
    description = "";
    longDescription = ''
      Space Grotesk is a proportional sans-serif typeface variant based on Colophon
      Foundry's fixed-width Space Mono family (2016). Originally designed by Florian
      Karsten in 2018, Space Grotesk retains the monospace's idiosyncratic details
      while optimizing for improved readability at non-display sizes.
    '';
    license = licenses.ofl;
    platforms = platforms.all;
    # NOTE TO SELF: package this into nixpkgs
    # maintainers = [ ];
  };
}
