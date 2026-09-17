{
  description = "KEROJAM's Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-26.05";
    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
	    url = "github:youwen5/zen-browser-flake";
	    inputs.nixpkgs.follows = "nixpkgs";
    };
   musnix.url = "github:musnix/musnix"; 
   focal.url = "github:iynaix/focal"; 
    #mikuPlymouth = {
    #  url = "github:Thang1191/MikuPlymouth";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
    #nur = {
    # url = "github:nix-community/NUR";
    # inputs.nixpkgs.follows = "nixpkgs";
    #};
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      #nur,
      musnix,
      mangowm,
      ...
    }@inputs:
    let
      stdenv.hostPlatform.system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.system;
      pkgs-stable = nixpkgs-stable.legacyPackages.system;
    in
    {
      nixosConfigurations = {
        YuriPC = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            #nur.modules.nixos.default
            ./main/configuration.nix
            ./main/hardware/hardware-configuration-main.nix
          ];
        };
        lily = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            #nur.modules.nixos.default
            ./main/configuration.nix
            ./main/hardware/hardware-configuration-Lap.nix
            mangowm.nixosModules.mango
            musnix.nixosModules.musnix
            #mikuPlymouth.nixosModules.default
          ];
        };
	server = nixpkgs.lib.nixosSystem {
	  specialArgs = { inherit inputs; };
	  modules = [
	  ./main/server.nix
	  ./main/hardware/hardware-configuration-server.nix
	  ];
	};
      };
    };
}
