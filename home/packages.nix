{ pkgs, ... }:

{
  home.packages = with pkgs; [
    htop
    pamixer
    floorp
    nautilus
    vesktop
    obs-studio
    gimp
    inkscape
    blockbench
    godot_4
    baobab
    steam 
    steam-run
    mindustry-wayland
    lutris
    mangohud
    mpv
    tmux
  ];
}
