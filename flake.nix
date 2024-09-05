{
  description = "Shiba's flake";

  # README: 
  # Leave comments that arent by me they might be helpful

  # Sorted by most important*
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable"; # Probably not gonna use it in home for packages
    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "git+https://github.com/sodiboo/niri-flake";
    stylix.url = "github:danth/stylix";
    nixvim = {
        url = "github:nix-community/nixvim";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    prismlauncher.url = "github:PrismLauncher/PrismLauncher";
  };

  outputs = { self, nixpkgs, home-manager, chaotic, auto-cpufreq, stylix, nixvim, prismlauncher, ... }@inputs: 
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./nixos/configuration.nix
        chaotic.nixosModules.default
        auto-cpufreq.nixosModules.default
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.shiba = import ./home/home.nix;
          home-manager.extraSpecialArgs = {inherit inputs;};
        }
        ({pkgs, ...}: {
          environment.systemPackages = [prismlauncher.packages.${pkgs.system}.prismlauncher];
        })
      ];
    };
  };
}
