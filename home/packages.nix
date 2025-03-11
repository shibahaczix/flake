{ lib, pkgs, inputs, ... }:

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
    godot_4 # Game engine
    mindustry-wayland # Game
    # lutris # Lutris
    mangohud # Mangohud
    mpv # Video player
    tmux # For ssh
    gimp # Paint
    gamescope # Upscale for games
    steam-run # FHS
    (steam.override { extraPkgs = pkgs: [ ]; }) # Steam
    (vintagestory.overrideAttrs (oldAttrs: {
      postInstall = oldAttrs.postInstall or "" + ''
        cp ${
          ./vintagestory/VintagestoryLib.dll
        } $out/share/vintagestory/VintagestoryLib.dll
      '';
      preFixup = oldAttrs.preFixup or "" + ''
        wrapProgram $out/bin/vintagestory \
          --prefix LD_LIBRARY_PATH : ${pkgs.gtk3}/lib
      '';
    })) # Game
    # kdenlive # Video editing
    losslesscut-bin # Lossless mp4 cutting
    # audacity # Sound editing
    # blender # 3D modeling
    amberol # Music player
    # yt-dlp # Youtube downloader
    # ventoy # Ventoy
    # caligula # USB image burner
    # ffmpeg # Video stuff
    protonup-qt # For managing Wine/Proton
    distrobox # For containers
    jetbrains.idea-community-bin # For Java/Kotlin programming because anything else sucks
    gcr # Provides org.gnome.keyring.SystemPrompter
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # Set Nautilus for directories and file handling
      "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
      "x-scheme-handler/file" = [ "org.gnome.Nautilus.desktop" ];
      "x-scheme-handler/trash" = [ "org.gnome.Nautilus.desktop" ];
    };
  };

  nixpkgs.config = {
    allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "steam-unwrapped"
        "steam"
        "steam-original"
        "steam-run"
        "discord-canary"
        "vintagestory"
      ];
    permittedInsecurePackages = [ "dotnet-runtime-7.0.20" ];
  };

}
