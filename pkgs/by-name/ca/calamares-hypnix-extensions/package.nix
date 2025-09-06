{
  stdenv,
  fetchFromGitHub,
  lib,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "calamares-hypnix-extensions";
  version = "0.0.35";

  src = fetchFromGitHub {
    owner = "gernotfeichter";
    repo = "hypnix";
    rev = "104e16b72f71618560dad8d0df61ae4fa3319390";
    hash = "sha256-mOCD8smBbY7PS6pBGd3Mc47qXzqISdvIOTfml5f19Ic=";
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
