{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mission-center
    fastfetch
    pamixer
    floorp
    wl-clipboard
    cliphist
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
  ];
}
