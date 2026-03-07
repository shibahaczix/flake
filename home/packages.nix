{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    # rtorrent
    piper
    equibop
    nautilus
    baobab
    gimp
    losslesscut-bin
    protonplus
    pavucontrol
    vlc
    conceal
    file-roller
    gnome-text-editor
    nvtopPackages.amd
    mangohud
    mangojuice
    kdePackages.kdenlive
    qemu
    # davinci-resolve
    # blender
    ghidra
    adwsteamgtk
    easyeffects
    protontricks
    gamescope_git
    (bottles.override { removeWarningPopup = true; })
  ];

  xdg.mimeApps.enable = true;
  xdg.desktopEntries = {
    "equibop" = {
      name = "Equibop";
      icon = "equibop";
      exec = "equibop --wayland";
    };
  };
}
