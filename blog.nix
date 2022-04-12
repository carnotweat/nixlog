{ mkDerivation, base, hedgehog, hpack, lib }:
mkDerivation {
  pname = "blog";
  version = "0.0.1.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base ];
  libraryToolDepends = [ hpack ];
  executableHaskellDepends = [ base ];
  testHaskellDepends = [ base hedgehog ];
  prePatch = "hpack";
  homepage = "https://github.com/carnotweat/blog#readme";
  description = "blog";
  license = lib.licenses.bsd3;
}
