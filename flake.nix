{
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" ] (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        hs = pkgs.haskellPackages;
      in
      rec {
        packages.data-list-unweave = hs.callCabal2nix "data-list-unweave" ./. { };
        defaultPackage = packages.data-list-unweave;

        apps.data-list-unweave = flake-utils.lib.mkApp { drv = packages.data-list-unweave; };
        defaultApp = apps.data-list-unweave;

        devShell = packages.data-list-unweave.env.overrideAttrs
          (super: {
            buildInputs = with hs; super.buildInputs ++ [
              cabal-install
              fourmolu
              haskell-language-server
              hlint
            ];
          });
      });
}
