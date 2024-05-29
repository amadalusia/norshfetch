{
  description = "norshfetch";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      flake.overlays.default = final: prev: {
        norshfetch = final.callPackage ./norshfetch.nix {
          inherit (prev) writeShellApplication;
        };
      };

      perSystem = { config, system, pkgs, ... }: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
        };

        formatter = pkgs.nixpkgs-fmt;

        packages.norshfetch = pkgs.norshfetch;
        packages.default = config.packages.norshfetch;

        apps.norshfetch.program = "${config.packages.norshfetch}/bin/norshfetch";
        apps.default.program = config.apps.norshfetch.program;
      };

      systems = [
        "x86_64-linux"
      ];
    };
}
