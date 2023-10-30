{
  pkgs,
  lib,
}:

let
  callPackage = pkg: pkgs.callPackage pkg;
in
  virtworld = pkgs.callPackage (import ./virtworld) {}