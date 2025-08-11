{
  pkgs,
  inputs,
  ...
}: {
  home.file.".config/sway".source = ./sway;

  services.mako = {
    enable = true;
    settings = {
      font = "JetBrainsMono NF 10";
      borderSize = 4;
      borderRadius = 5;
      borderColor = "#95e6cbff";
      backgroundColor = "#171717ff";
    };
  };

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "kitty";
        font = "JetBrainsMono NF";
        line-height = 22;
      };
      colors.background = "171717ff";
      colors.border = "95e6cbff";
      colors.text = "ffffffff";
      colors.selection = "#101010ff";
      colors.selection-text = "#f0f0f0ff";
      border.width = 4;
    };
  };

  services.gammastep = {
    enable = true;
    provider = "manual";
    # Desktop
    latitude = 52.2;
    longitude = 18.2;
  };
}
