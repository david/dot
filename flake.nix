{
  description = "System flake";

  inputs = {
    emacs = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  };

  outputs = {
    emacs-overlay,
    hm,
    nixos-hardware,
    nixpkgs,
    ...
  } @ inputs : let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;

      config.allowUnfree = true;

      overlays = [ 
        emacs-overlay.overlay
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
          ./nix/configuration.nix

          hm.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.david = import ./nix/home.nix;
          }
        ];
      };
    };
  };
}
