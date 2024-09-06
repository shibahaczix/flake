{ pkgs, ... }:

{
  programs.fuzzel.enable = true;
  programs.fuzzel.settings = {
    main = {
      terminal = "${pkgs.kitty}/bin/kitty";
      layer = "overlay";
    };
    colors.background = "171717ff";
    colors.border = "95e6cbff";
    border.width = 4;
    font.size = 11.5;
  };
}
