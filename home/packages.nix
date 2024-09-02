{ pkgs, ... }:

{
  home.packages = with pkgs; [
    htop
    #mission-center
    fastfetch
    pamixer
    floorp
    grim
    slurp
    nautilus
    vesktop
    obs-studio
    swww
    gimp
    remmina
    blockbench
    godot_4
    xwayland-run
    baobab
    wlr-randr
  ];
}
