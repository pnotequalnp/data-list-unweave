{
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" ] (system:
      let
        overlay = self: super: {
          haskell = super.haskell // {
            packageOverrides = hsSelf: hsSuper: {
              data-list-unweave = hsSelf.callCabal2nix "data-list-unweave" ./. { };
            };
          };
        };
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ overlay ];
        };
        hs = pkgs.haskellPackages;
      in
      rec {
        inherit overlay;

        packages = rec {
          data-list-unweave = hs.data-list-unweave;
          default = data-list-unweave;
        };

        apps = rec {
          data-list-unweave = flake-utils.lib.mkApp { drv = packages.data-list-unweave; };
          default = data-list-unweave;
        };

        # Compatibility for older Nix versions
        defaultApp = apps.default;
        defaultPackage = packages.default;

        devShell = hs.shellFor {
          packages = hsPkgs: with hsPkgs; [ data-list-unweave ];
          nativeBuildInputs = with hs; [
            cabal-install
            fourmolu
            haskell-language-server
            hlint
          ];
        };
      });
}
