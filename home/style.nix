{ pkgs, ... }:

{
  # TODO: make me work
  home.pointerCursor = {
    enable = true;
    name = "macOS";
    package = pkgs.apple-cursor;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
    sway.enable = true;
  };

  gtk = {
    enable = true;
    # TODO: font = {};
    theme = {
      name = "Fluent-Dark";
      # TODO: gtkThemeFromScheme, manually defined w colors? (nix-colors)
      package = pkgs.fluent-gtk-theme;
    };

    iconTheme = {
      name = "Fluent-Dark";
      package = pkgs.fluent-icon-theme;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
}
