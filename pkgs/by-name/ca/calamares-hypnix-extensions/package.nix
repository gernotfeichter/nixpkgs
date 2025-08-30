{
  stdenv,
  fetchFromGitHub,
  lib,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "calamares-hypnix-extensions";
  version = "0.0.29";

  src = fetchFromGitHub {
    owner = "gernotfeichter";
    repo = "hypnix";
    rev = "7ea01c691a2db5191830e7b25349e9566bb67086";
    hash = "sha256-dtEHL0dlHS9Jxwrqu2E8w3ylXNc+ullxmSBpm9+ICTY=";
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
