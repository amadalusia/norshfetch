{
  description = "norshfetch";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{flake-parts, ...}:
    flake-parts.lib.mkFlake { inherit inputs; } {
      perSystem = {pkgs, config, ...}: {
        packages.norshfetch = pkgs.callPackage ./norshfetch.nix {};
        packages.default = config.packages.norshfetch;

        apps.norshfetch.program = "${config.packages.norshfetch}/bin/norshfetch";
        apps.default.program = config.apps.norshfetch.program;
      };
      
      systems = [
        "x86_64-linux"
      ];
    };
}
