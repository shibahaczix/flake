{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    inputs.zen-browser.packages."${system}".generic
    steam
    steam-run
    pamixer
    nautilus
    vesktop
    obs-studio
    gimp
    godot_4
    baobab
    mindustry-wayland
    lutris
    mangohud
    mpv
    tmux
    kdenlive
    amberol
    yt-dlp
  ];
}
