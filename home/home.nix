{ config, pkgs, inputs, ... }:

{
  home.username = "shiba";
  home.homeDirectory = "/home/shiba";

  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    inputs.hyprland.homeManagerModules.default
    inputs.nixvim.homeManagerModules.nixvim
    inputs.niri.homeModules.niri
    ./packages.nix
    ./git.nix
    ./shell.nix
    ./gammastep.nix
    ./niri.nix
    ./fastfetch.nix
    ./fuzzel.nix
    ./cliphist.nix
    ./kitty.nix
    ./stylix.nix # Automatic home-manager module detection
    ./eww.nix
    ./nixvim.nix
  ];

  # Symlink example
  # home.file.".zshrc".source = ./zshrc; 

  # Programs and services here



  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
