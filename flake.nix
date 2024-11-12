{
  description = "KEROJAM's Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    matugen.url = "github:InioX/matugen?ref=v2.2.0";
    ags.url = "github:Aylur/ags";
    astal.url = "github:Aylur/astal";
  };

  outputs = { self, nixpkgs, home-manager, nur, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.system;
  in
    {
    packages.x86_64-linux.default = pkgs.callPackage ./ags {inherit inputs;};
    nixosConfigurations.YuriPC = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        nur.nixosModules.nur
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
      ];
    };
  };
}
