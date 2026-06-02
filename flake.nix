{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.3";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lollipop.url = "github:lavafroth/lollipop";

    helium = {
      url = "github:schembriaiden/helium-browser-nix-flake";
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
    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      lanzaboote,
      sops-nix,
      nix-on-droid,
      lollipop,
      ...
    }@inputs:

    let
      cafeModules = [
        ./hosts/default/configuration.nix
        ./hosts/default/stylix.nix
        lollipop.nixosModules.default
        # https://github.com/NixOS/nixpkgs/pull/498572
        {
          environment.systemPackages = [
            inputs.helium.packages.${system}.default
          ];
        }
      ];

      secureBootModules = [
        lanzaboote.nixosModules.lanzaboote
        ./hosts/default/secureboot.nix
      ];
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
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
