{ pkgs, ... }:

{
  stylix = {
    polarity = "dark";
    base16Scheme = {
      base00 = "0c0c0c";
      base01 = "2f2f2f";
      base02 = "535353";
      base03 = "767676";
      base04 = "b9b9b9";
      base05 = "cccccc";
      base06 = "dfdfdf";
      base07 = "f2f2f2";
      base08 = "e74856";
      base09 = "c19c00";
      base0A = "f9f1a5";
      base0B = "16c60c";
      base0C = "61d6d6";
      base0D = "3b78ff";
      base0E = "b4009e";
      base0F = "13a10e";
    };

    targets = {
      gtk.enable = true;
      nixvim.enable = false;
      kitty.enable = false;
      fish.enable = false;
      fuzzel.enable = false;
      vesktop.enable = true;
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    fonts = {
      serif = {
        package = pkgs.jetbrains-mono;
        name = "JetBrainsMonoNL NF SemiBold";
      };

      sansSerif = {
        package = pkgs.jetbrains-mono;
        name = "JetBrainsMonoNL NF SemiBold";
      };

      monospace = {
        package = pkgs.jetbrains-mono;
        name = "JetBrainsMonoNL NF SemiBold";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 12;
        terminal = 12;
        desktop = 12;
        popups = 12;
      };
    };
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Fluent-Dark";
      package = pkgs.fluent-icon-theme;
    };
  };
}
