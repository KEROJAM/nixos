{
  description = "KEROJAM's Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    dwmblocks = {
      url = "github:KEROJAM/dwmblocks";
      flake = false;
    };
    dwm = {
      url = "github:KEROJAM/dwm";
      flake = false;
    };
    awesome-git = {
      url = "github:awesomeWM/awesome";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, nur, nix-flatpak, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.system;
  in
    {
    nixosConfigurations = { 
      YuriPC = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
            nur.modules.nixos.default
            nix-flatpak.nixosModules.nix-flatpak
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
            nur.modules.nixos.default
            nix-flatpak.nixosModules.nix-flatpak
            ./main/configuration.nix
            ./main/hardware/hardware-configuration-Lap.nix
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
    };
  };
}
