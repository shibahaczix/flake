{ lib, pkgs, inputs, ... }: {
  home.packages = with pkgs; [
    inputs.zen-browser.packages."${system}".generic # Web browser
    rtorrent
    piper
    (discord-canary.override {
      withOpenASAR = true;
      withVencord = true;
    })
    pamixer
    element-desktop
    nautilus
    baobab
    gimp
    losslesscut-bin
    protonplus
    #jetbrains.idea-community
    pavucontrol
    protontricks
    eza
    bat
    vlc
    quickemu
    conceal
    file-roller
    gnome-text-editor
    adwsteamgtk
    nvtopPackages.amd
    mangohud
    mangojuice
    cozette
    kdePackages.kdenlive
    #davinci-resolve
  ];

  xdg.desktopEntries = {
    "idea-community" = {
      name = "IntelliJ IDEA CE (Wayland)";
      icon = "idea-community";
      exec = "idea-community -Dawt.toolkit.name=WLToolkit";
      categories = [ "Development" "IDE" ];
      terminal = false;
    };
    "discord-canary" = {
      name = "Discord Canary (Wayland)";
      icon = "discord-canary";
      exec =
        "env NIXOS_OZONE_WL=1 discordcanary --ignore-gpu-blocklist --disable-features=UseOzonePlatform --enable-features=VaapiVideoDecoder --use-gl=desktop --enable-gpu-rasterization --enable-zero-copy";
      categories = [ "" ];
      terminal = false;
    };
  };

  nixpkgs.config = {
    allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "discord-canary"
        "apple_cursor"
        "davinci-resolve"
      ];
    # permittedInsecurePackages = [ ];
  };
}
