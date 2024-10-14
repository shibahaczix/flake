{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    inputs.zen-browser.packages."${system}".generic # Web browser
    gnome-calendar # Calendar
    steam # Stean app
    steam-run # For running
    pamixer # Audio
    cinny-desktop # Matrix client
    nautilus # File manager
    vesktop # Discord
    gimp # Paint
    baobab # Disk checker
    godot_4 # Game engine
    mindustry-wayland # Game
    lutris # Lutris
    mangohud # Mangohud
    mpv # Video player
    tmux # For ssh
    kdenlive # Video editing
    amberol # Music player
    yt-dlp # Youtube downloader
    ffmpeg # Video stuff
  ];
}
