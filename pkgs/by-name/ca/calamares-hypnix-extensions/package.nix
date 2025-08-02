{
  stdenv,
  fetchFromGitHub,
  lib,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "calamares-hypnix-extensions";
  version = "0.0.22";

  src = fetchFromGitHub {
    owner = "gernotfeichter";
    repo = "hypnix";
    rev = "0108a9975c79cf5637f004e38b793d5fc409f0fd";
    hash = "sha256-voEZOCN4Zsa09Nj7ERBLQeZdDMkWH5rOhIc9rI1bN24=";
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
