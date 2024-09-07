{ pkgs, ... }:

{
  programs.fuzzel.enable = true;
  programs.fuzzel.settings = {
    main = {
      terminal = "kitty";
      font = "JetBrainsMono NF SemiBold";
      line-height = 22;
    };
    colors.background = "171717ff";
    colors.border = "95e6cbff";
    colors.text = "ffffffff";
    colors.selection = "#101010ff";
    colors.selection-text = "#f0f0f0ff";
    border.width = 4;
  };
}
