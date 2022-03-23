# data-list-unweave
This is a simple Haskell package that is more intended to demonstrate Haskell packaging than it is
intended to be useful as a Haskell package.

## CI

### Tests
The package is automatically built, and tests are run:
[![Nix CI](https://github.com/pnotequalnp/data-list-unweave/actions/workflows/nix.yml/badge.svg?branch=main)](https://github.com/pnotequalnp/data-list-unweave/actions/workflows/nix.yml)

### Documentation
The Haddock docs are automatically built and pushed to the `doc` branch, and are available
[online](https://pnotequalnp.github.io/data-list-unweave).

### Binary
The binary for the executable is automatically built, a release is created, and the binary is
uploaded to that release as an asset.

## Usage

### Cabal
You'll need to create a `cabal.project` file for your project. In that file, specify a remote source
repository like this:
```
packages: .

source-repository-package
    type: git
    location: https://github.com/pnotequalnp/data-list-unweave.git
    tag: <commit hash>
```
Replace the `<commit hash>` with the hash of the commit you want to use. Add `data-list-unweave` to
your `build-depends` like normal, and cabal will automatically download and build the library from
GitHub.

### Nix (Flakes)
You'll want to add it to your Haskell package set with an override. That might look like this:

``` nix
{
  inputs = {
    # ...
    data-list-unweave.url = "github:pnotequalnp/data-list-unweave";
  };

  outputs = { data-list-unweave, ... }:
    let hs = pkgs.haskellPackages.override {
          overrides = self: super: {
            data-list-unweave = data-list-unweave.packages.${system}.data-list-unweave;
          };
        };
     in {
    # ...
  };
}
```
Then add it to your `build-depends` like usual.
