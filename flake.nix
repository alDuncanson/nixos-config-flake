{
  description = "NixOS flake | Al Duncanson";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dotfiles.url = "github:alDuncanson/dotfiles";
  };

  outputs =
    inputs@{
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      dotfiles,
      ...
    }:
    let
      system = "x86_64-linux";
      dotfilesForSystem = dotfiles.inputs.flake-parts.lib.mkFlake { inherit inputs; } {
        imports = [ dotfiles.flakeModules.default ];
        systems = [ system ];
      };
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfreePredicate = pkg: nixpkgs.lib.getName pkg == "amp-cli";
      };
    in
    {
      nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          neovim = dotfilesForSystem.packages.${system}.neovim;
          amp = unstable.amp-cli;
        };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.al = import ./home.nix;
          }
        ];
      };
    };
}
