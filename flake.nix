{
  description = "My flake thingy";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";
    catppuccin.url = "github:catppuccin/nix";

    zen-browser.url = "github:0xc000022070/zen-browser-flake/revert-155-fix/zen-symlink";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    hypredge = {
      url = "github:CyrenArkade/hypredge";
      # url = "git+file:///home/cyren/dev/cpp/hypredge";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, zen-browser, ... }:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {

    packages.${system}.zen-with-sine = import ./home/zen/zen-with-sine.nix {
      inherit pkgs zen-browser inputs;
    };

    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs outputs; };
        modules = [ ./configuration.nix ];
      };
    };
    homeConfigurations = {
      alysara = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs outputs; };
        modules = [ ./home/home.nix ];
      };
    };
  };
}
