{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    # rtorrent
    piper
    (discord-canary.override {
      # withOpenASAR = true;
      withVencord = true;
    })
    nautilus
    baobab
    gimp
    losslesscut-bin
    protonplus
    #jetbrains.idea-community
    pavucontrol
    vlc
    conceal
    file-roller
    gnome-text-editor
    # adwsteamgtk
    nvtopPackages.amd
    mangohud
    mangojuice
    # kdePackages.kdenlive
    qemu
    #davinci-resolve
    # blender
    (bottles.override { removeWarningPopup = true; })
    easyeffects
  ];

  xdg.mimeApps.enable = true;

  xdg.desktopEntries = {
    "idea-community" = {
      name = "IntelliJ IDEA CE (Wayland)";
      icon = "idea-community";
      exec = "idea-community -Dawt.toolkit.name=WLToolkit";
      categories = [
        "Development"
        "IDE"
      ];
      terminal = false;
    };

    "discord-canary" = {
      name = "Discord Canary (Wayland)";
      icon = "discord-canary";
      exec = "env NIXOS_OZONE_WL=1 discordcanary --ignore-gpu-blocklist --enable-features=VaapiVideoDecoder --use-gl=desktop --enable-gpu-rasterization --enable-zero-copy --enable-features=UseOzonePlatform --ozone-platform=wayland";
      categories = [ "" ];
      terminal = false;
    };
  };
}
