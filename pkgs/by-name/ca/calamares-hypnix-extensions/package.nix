{
  stdenv,
  fetchFromGitHub,
  lib,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "calamares-hypnix-extensions";
  version = "0.0.25";

  src = fetchFromGitHub {
    owner = "gernotfeichter";
    repo = "hypnix";
    rev = "6c33e0cb6af18a5beb8b8422888166d5cef44eca";
    hash = "sha256-fIl+lTxsnTd5YlboJXj8Wluf1V2BZXsZpEa38Qi/E78=";
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
