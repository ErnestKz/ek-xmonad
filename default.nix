let
  sources = import ./nix/sources.nix;
  pkgs = (import sources.ek)
    .redirect
    .nixpkgs-with-overlay;
in
pkgs.ek.haskell.package-set.ghc92.callCabal
  "ek-xmonad" ./. {}
  
