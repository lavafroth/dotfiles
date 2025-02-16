{
  lib,
  stdenvNoCC,
  fetchzip,
}:

stdenvNoCC.mkDerivation rec {
  pname = "space-grotesk";
  version = "2.0.0";

  src = fetchzip {
    url = "https://github.com/floriankarsten/space-grotesk/releases/download/${version}/SpaceGrotesk-${version}.zip";
    stripRoot = false;
    hash = "sha256-niwd5E3rJdGmoyIFdNcK5M9A9P2rCbpsyZCl7CDv7I8=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/truetype
    install -Dm644 SpaceGrotesk-${version}/ttf/static/*.ttf $out/share/fonts/truetype/

    runHook postInstall
  '';

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
