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
    ./fuzzel.nix
    ./kitty.nix
    ./stylix.nix
    ./fonts.nix
    ./eww.nix
    ./nixvim.nix # Might switch to helix if i like it
    ./prismlauncher.nix
  ];

  # Symlink example
  # home.file.".zshrc".source = ./zshrc; 

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
