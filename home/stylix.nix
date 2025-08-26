{pkgs, ...}: {
  stylix = {
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/material-darker.yaml";

    targets = {
      gtk.enable = true;
      mako.enable = false;
      kitty.enable = false;
      fish.enable = false;
      fuzzel.enable = false;
      btop.enable = false;
      nvf.enable = false;
      sway.enable = false;
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    fonts = {
      serif = {
        package = pkgs.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };

      sansSerif = {
        package = pkgs.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };

      monospace = {
        package = pkgs.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
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

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [nerd-fonts.jetbrains-mono];
}
