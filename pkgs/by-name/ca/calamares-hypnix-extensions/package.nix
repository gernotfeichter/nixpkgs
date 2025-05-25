{
  stdenv,
  fetchFromGitHub,
  lib,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "calamares-hypnix-extensions";
  version = "0.0.20";

  src = fetchFromGitHub {
    owner = "gernotfeichter";
    repo = "hypnix";
    rev = "979141a97d343184977dffce114a3de58e27ca51";
    hash = "sha256-4BVGD9O1VvtV5P3PPV8feTY/P5yhW8YzQfi2RHwSK4o=";
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/{lib,share}/calamares
    cp -r modules $out/lib/calamares/
    cp -r config/* $out/share/calamares/
    cp -r branding $out/share/calamares/
    runHook postInstall
  '';

  meta = with lib; {
    description = "Calamares modules for Hypnix";
    homepage = "https://github.com/gernotfeichter/hypnix";
    license = with licenses; [
      gpl3Plus
      bsd2
      cc-by-40
      cc-by-sa-40
      cc0
    ];
    maintainers = with maintainers; [ gernotfeichter ];
    platforms = platforms.linux;
  };
})
