{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mustache2konsole = {
      url = "github:lavafroth/mustache2konsole";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      lanzaboote,
      sops-nix,
      nix-on-droid,
      nix-index-database,
      stylix,
      nix-ld,
      mustache2konsole,
      ...
    }:

    let
      cafeModules = [
        ./hosts/default/configuration.nix
        ./cachix/nix-community.nix
        home-manager.nixosModules.home-manager
        ./hosts/default/stylix.nix
        stylix.nixosModules.stylix
        nix-index-database.nixosModules.nix-index
        { programs.nix-index-database.comma.enable = true; }
        { nixpkgs.overlays = [ mustache2konsole.overlays.default ]; }

        # uni requires us to use uv for python
        # RIP binary isolation lol
        nix-ld.nixosModules.nix-ld
      ];

      secureBootModules = [
        lanzaboote.nixosModules.lanzaboote
        ./hosts/default/secureboot.nix
      ];
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
      };

    in

    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      nixosConfigurations = {
        cafe-nosecureboot = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = cafeModules;
        };

        cafe = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = cafeModules ++ secureBootModules;
        };

        rahu = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            ./hosts/rahu/configuration.nix
            sops-nix.nixosModules.sops
          ];
        };
      };

      nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
        modules = [ ./hosts/aqua/nix-on-droid.nix ];
      };

    };
}
