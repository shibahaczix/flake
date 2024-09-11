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
    krita
    blockbench
    godot_4
    baobab
    steam 
    steam-run
    mindustry-wayland
    lutris
    mangohud
  ];
}
