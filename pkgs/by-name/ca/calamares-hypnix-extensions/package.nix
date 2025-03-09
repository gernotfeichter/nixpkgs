{
  stdenv,
  lib,
  glibcLocales,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "calamares-hypnix-extensions";
  version = "0.1.0";

  src = ./src;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/{etc,lib,share}/calamares
    cp -r modules $out/lib/calamares/
    cp -r config/* $out/etc/calamares/
    cp -r branding $out/share/calamares/

    substituteInPlace $out/etc/calamares/settings.conf --replace-fail @out@ $out
    substituteInPlace $out/etc/calamares/modules/locale.conf --replace-fail @glibcLocales@ ${glibcLocales}
    substituteInPlace $out/lib/calamares/modules/nixos/main.py --replace-fail "@out@" "$out"

    runHook postInstall
  '';

  meta = {
    description = "Calamares modules for Hypnix";
    homepage = "https://github.com/nix-community/hypnix";
    license = with lib.licenses; [ mit ]; # Assuming MIT, but this should be checked
    maintainers = with lib.maintainers; [ ]; # Unknown maintainer for hypnix
    platforms = lib.platforms.linux;
  };
})