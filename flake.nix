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
    matugen.url = "github:InioX/matugen?ref=v2.2.0";
    ags.url = "github:Aylur/ags/v1";
    astal.url = "github:Aylur/astal";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
  };

  outputs = { self, nixpkgs, home-manager, nur, nixpkgs-f2k , ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.system;
  in
    {
    packages.system.default = pkgs.callPackage ./ags {inherit inputs;};
    nixosConfigurations.YuriPC = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        nur.modules.nixos.default
        ./main/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.extraSpecialArgs = {
            inherit inputs;
            inherit system;
          };
          home-manager.useGlobalPkgs = true;
          home-manager.users."kerojam" = import ./home-manager/home.nix;
        }
        {
          nixpkgs.overlays = [
            nixpkgs-f2k.overlays.window-managers
          ];
        }
      ];
    };
  };
}
