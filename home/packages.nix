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
    swww
    gimp
    blockbench
    godot_4
    xwayland-run
    baobab
    wlr-randr
  ];
}
