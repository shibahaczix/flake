{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    inputs.zen-browser.packages."${system}".generic # Web browser
    rtorrent # Torrenting
    piper # Mouse software
    (discord-canary.override {
      withOpenASAR = true;
      withVencord = true;
    }) # Discord
    gnome-calendar # Calendar
    pamixer # Audio -/+
    element-desktop # Matrix client
    nautilus # File manager
    baobab # Disk checker
    #godot_4 # Game engine
    mindustry-wayland # Game
    #lutris # Lutris
    steam # Steam
    steam-run # FHS
    mangohud # Mangohud
    mpv # Video player
    tmux # For ssh
    gimp # Paint
    #wasabiwallet # Crypto wallet
    #kdenlive # Video editing
    #audacity # Sound editing
    #blender # 3D modeling
    amberol # Music player
    #yt-dlp # Youtube downloader
    #ventoy # Ventoy
    #caligula # USB image burner
    #ffmpeg # Video stuff
    protonup-qt
  ];
}
