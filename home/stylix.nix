{ pkgs, ... }:

{
  # Style related
  stylix = {
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/material-darker.yaml";

    targets = {
      gtk.enable = true;
      mako.enable = false;
      helix.enable = false;
      kitty.enable = false;
      fish.enable = false;
      fuzzel.enable = false;
      btop.enable = false;
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    fonts = {
      serif = {
        package = pkgs.jetbrains-mono;
        name = "JetBrainsMono SemiBold";
      };

      sansSerif = {
        package = pkgs.jetbrains-mono;
        name = "JetBrainsMono SemiBold";
      };

      monospace = {
        package = pkgs.jetbrains-mono;
        name = "JetBrainsMono SemiBold";
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
  home.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];
}
