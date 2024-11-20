{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    inputs.zen-browser.packages."${system}".generic # Web browser
    qbittorrent # Torrenting
    piper # Mouse software
    vesktop # Discord
    gnome-calendar # Calendar
    steam # Stean app
    steam-run # For running
    pamixer # Audio
    element-desktop # Matrix client
    nautilus # File manager
    baobab # Disk checker
    #godot_4 # Game engine
    mindustry-wayland # Game
    #lutris # Lutris
    mangohud # Mangohud
    mpv # Video player
    tmux # For ssh
    gimp # Paint
    #kdenlive # Video editing
    #audacity # Sound editing
    #blender # 3D modeling
    amberol # Music player
    yt-dlp # Youtube downloader
    ffmpeg # Video stuff
    protonup-qt
  ];
}
