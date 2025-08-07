{
  lib,
  pkgs,
  inputs,
  ...
}: {
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
    # godot_4 # Game engine
    # mindustry-wayland # Game
    # lutris # Lutris
    mangohud # Mangohud
    # mpv # Video player
    gimp # Paint
    # kdenlive # Video editing
    losslesscut-bin # Lossless mp4 cutting
    # audacity # Sound editing
    # blender # 3D modeling
    # amberol # Music player
    # yt-dlp # Youtube downloader
    # ventoy # Ventoy
    # caligula # USB image burner
    # ffmpeg # Video stuff
    #protonup-qt # For managing Wine/Proton
    protonplus
    #jetbrains.idea-community # For Java/Kotlin programming because anything else sucks
    nix-melt # flake.lock viewer
    pavucontrol # Volume control
    protontricks # For games
    eza
    bat
    fd
    ripgrep
    fzf
    vlc
    quickemu
    conceal
    mission-center
    file-roller
    gnome-text-editor
  ];

  xdg.desktopEntries = {
    "idea-community" = {
      name = "IntelliJ IDEA CE (Wayland)";
      icon = "idea-community";
      exec = "idea-community -Dawt.toolkit.name=WLToolkit";
      categories = ["Development" "IDE"];
      terminal = false;
    };
    "discord-canary" = {
      name = "Discord Canary (Wayland)";
      icon = "discord-canary";
      exec = "env NIXOS_OZONE_WL=1 discordcanary --ignore-gpu-blocklist --disable-features=UseOzonePlatform --enable-features=VaapiVideoDecoder --use-gl=desktop --enable-gpu-rasterization --enable-zero-copy";
      categories = [""];
      terminal = false;
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # Set Nautilus for directories and file handling
      "inode/directory" = ["org.gnome.Nautilus.desktop"];
      "x-scheme-handler/file" = ["org.gnome.Nautilus.desktop"];
      "x-scheme-handler/trash" = ["org.gnome.Nautilus.desktop"];
      "x-scheme-handler/terminal" = ["kitty.desktop"];
    };
  };

  nixpkgs.config = {
    allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) ["discord-canary"];
    # permittedInsecurePackages = [ ];
  };
}
