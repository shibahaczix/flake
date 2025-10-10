{ ... }:

{
  programs.btop = {
    enable = true;

    settings = {
      signByDefault = true;
      theme_background = false;
      color_theme = "ayu";
    };
  };
}
