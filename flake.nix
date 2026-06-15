{
  description = "KEROJAM's Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #mikuPlymouth = {
    #  url = "github:Thang1191/MikuPlymouth";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
    #nur = {
    # url = "github:nix-community/NUR";
    # inputs.nixpkgs.follows = "nixpkgs";
    #};
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      #nur,
      spicetify-nix,
      mangowm,
     # mikuPlymouth,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.system;
    in
    {
      nixosConfigurations = {
        YuriPC = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            #nur.modules.nixos.default
            ./main/configuration.nix
            ./main/hardware/hardware-configuration-main.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit system;
              };
              home-manager.useGlobalPkgs = true;
              home-manager.users."kerojam" = import ./home-manager/home.nix;
            }
          ];
        };
        lily = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            #nur.modules.nixos.default
            ./main/configuration.nix
            ./main/hardware/hardware-configuration-Lap.nix
            mangowm.nixosModules.mango
            #mikuPlymouth.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit system;
              };
              home-manager.useGlobalPkgs = true;
              home-manager.users."kerojam" = import ./home-manager/home.nix;
            }
          ];
        };
	server = nixpkgs-stable.lib.nixosSystem {
	  specialArgs = { inherit inputs; };
	  modules = [
	  ./main/server.nix
	  ./main/hardware/hardware-configuration-server.nix
	  ];
	};
      };
    };
}
