{
  outputs = inputs@{self, flake-parts, ...}
    flake-parts.lib.mkFlake {
      perSystem = {pkgs, config, ...}: {
        packages = {
          norshfetch = pkgs.callPackage ./wrapper.nix;
          default = config.packages.norshfetch;
        };
      };
      systems = [
        "x86_64-linux"
      ];
    };
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-parts = "github:hercules-ci/flake-parts";
  };
}
