{ pkgs, ... }:

{
  home.packages = with pkgs; [
    htop
    fastfetch
    pamixer
    floorp
    nautilus
    vesktop
    obs-studio
    gimp
    blockbench
    godot_4
    baobab
    steam
    steam-run
  ];
}
