let
  pkgs = import <nixpkgs> {};
in
pkgs.callPackage (import ./libvirtping.nix) {}