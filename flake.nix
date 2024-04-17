{
  description = "System flake";

  inputs = {
    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hypridle.url = "github:hyprwm/hypridle";
    hyprland.url = "github:hyprwm/hyprland";
    hyprlock.url = "github:hyprwm/hyprlock";
    hyprpaper.url = "github:hyprwm/hyprpaper";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixvim.url = "github:nix-community/nixvim";

    tree-sitter-nu = {
      url = "github:nushell/tree-sitter-nu";
      flake = false;
    };
  };

  outputs = {
    hm,
    hypridle,
    hyprland,
    hyprlock,
    hyprpaper,
    neovim-nightly-overlay,
    nixos-hardware,
    nixpkgs,
    nixvim,
    tree-sitter-nu,
    ...
  } @ inputs : let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;

      config.allowUnfree = true;

      overlays = [ neovim-nightly-overlay.overlay ];
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
            home-manager.extraSpecialArgs = {
              inherit inputs;

              colors = import ./nix/colors.nix;
            };

            home-manager.sharedModules = [
              hypridle.homeManagerModules.default
              hyprlock.homeManagerModules.default
              hyprpaper.homeManagerModules.default
              nixvim.homeManagerModules.nixvim
            ];

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.david = import ./nix/home.nix;
          }
        ];
      };
    };
  };
}
