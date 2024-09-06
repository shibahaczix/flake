{ pkgs, ... }:

{
  programs.fuzzel.enable = true;
  programs.fuzzel.settings = {
    main = {
      terminal = "${pkgs.kitty}/bin/kitty";
      layer = "overlay";
      font = "JetBrainsMono NF";
      line-height = 22;
    };
    colors.background = "171717ff";
    colors.border = "95e6cbff";
    colors.text = "ffffffff";
    border.width = 4;
  };
}
