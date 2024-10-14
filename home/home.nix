{ ... }:

{
  home.username = "shiba";
  home.homeDirectory = "/home/shiba";

  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./packages.nix
    ./git.nix
    ./shell.nix
    ./niri.nix
    ./fastfetch.nix
    ./htop.nix
    ./fuzzel.nix
    ./kitty.nix
    ./stylix.nix
    ./fonts.nix
    ./obs.nix
    ./eww.nix
    ./helix.nix
    ./prismlauncher.nix
  ];

  # Symlink example
  # home.file.".zshrc".source = ./zshrc; 

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
