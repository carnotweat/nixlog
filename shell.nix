{ nixpkgs ? import <nixpkgs> {}, compiler ? "default", doBenchmark ? false }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, base, hedgehog, hpack, lib }:
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
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  variant = if doBenchmark then pkgs.haskell.lib.doBenchmark else pkgs.lib.id;

  packages = haskellPackages.callCabal2nix "blog" ./blog.cabal {};
in

  haskellPackages.shellFor {
  withHoogle = true;
  packages = p: [ packages ];
#  buildInputs = builtins.attrValues nixpkgs.haskellPackages.devtools;
#  shellHook = ''
#    ${nixpkgs.ci.pre-commit-check.shellHook}
#  '';
}
