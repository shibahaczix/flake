{ ... }:

{
  home.username = "shiba";
  home.homeDirectory = "/home/shiba";

  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./packages.nix
    ./git.nix
    ./fastfetch.nix
    ./btop.nix
    ./kitty.nix
    ./stylix.nix
    ./niri.nix
    ./shell.nix
    ./obs.nix
    ./helix.nix
    ./prismlauncher.nix
  ];

  # Symlink example
  # home.file.".zshrc".source = ./zshrc; 

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
