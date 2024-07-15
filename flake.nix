{
  description = "System flake";

  inputs = {
    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    stylix.url = "github:danth/stylix";
  };

  outputs = {
    hm,
    neovim-nightly-overlay,
    nixos-hardware,
    nixpkgs,
    nixvim,
    stylix,
    ...
  } @ inputs : let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;

      config.allowUnfree = true;

      overlays = [
        neovim-nightly-overlay.overlays.default
      ];
    };
  in {
    nixosConfigurations = {
      timbuktu = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit pkgs;

        specialArgs = { inherit inputs; };

        modules = [
          ./nix/hardware-configuration.nix
          nixos-hardware.nixosModules.tuxedo-infinitybook-pro14-gen7
          stylix.nixosModules.stylix
          ./nix/configuration.nix

          { nixpkgs.overlays = [ neovim-nightly-overlay.overlays.default ]; }

          hm.nixosModules.home-manager {
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };

            home-manager.sharedModules = [
              nixvim.homeManagerModules.nixvim
            ];

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.david = import ./nix/home.nix;
          }

          ./nix/theme.nix
        ];
      };
    };
  };
}
