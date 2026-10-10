{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    helium.url = "github:oxcl/nix-flake-helium-browser";
    helium.inputs.nixpkgs.follows = "nixpkgs";

    colorctl.url = "github:Curstantine/colorctl";
    colorctl.inputs.nixpkgs.follows = "nixpkgs";

    creativocode.url = "/home/curstantine/Code/CreativoCode/platforms";
    creativocode.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let
      keys = import ./keys.nix;
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
      nixosConfigurations = {
        maomao = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs keys; };
          modules = [
            {
              nix.settings.experimental-features = [
                "nix-command"
                "flakes"
              ];
            }
            ./maomao/configuration.nix
          ];
        };

        menow = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs keys; };
          modules = [
            {
              nix.settings.experimental-features = [
                "nix-command"
                "flakes"
              ];
            }
            ./menow/configuration.nix
          ];
        };
      };
    };
}
