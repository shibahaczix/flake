{
  pkgs,
  ...
}:

{
  home.pointerCursor = {
    enable = true;
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;

    theme = {
      name = "Fluent-Dark";
      package = pkgs.fluent-gtk-theme;
    };

    iconTheme = {
      name = "Fluent-Dark";
      package = pkgs.fluent-icon-theme;
    };
  };

  qt = {
    enable = true;
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };
}
