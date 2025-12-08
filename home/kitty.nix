{
  ...
}:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMonoNL NF";
      size = 11.5;
    };

    settings = {
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      shell = "fish";

      enable_audio_bell = false;

      confirm_os_window_close = 0;
      cursor_trail = 1;
      # background_blur = 5;

      background_opacity = "1.0";
      window_border_width = "0px";
      tab_bar_margin_width = "0.0";

      cursor = "#ffcc66";

      background = "#0f1014";
      foreground = "#d9d7ce";

      selection_background = "#343f4c";
      selection_foreground = "#212733";

      # black  (bg3/bg4)
      color0 = "#191e2a";
      color8 = "#686868";

      # red
      color1 = "#ed8274";
      color9 = "#f28779";

      # green
      color2 = "#a6cc70";
      color10 = "#bae67e";

      # yellow
      color3 = "#fad07b";
      color11 = "#ffd580";

      # blue
      color4 = "#6dcbfa";
      color12 = "#73d0ff";

      # purple
      color5 = "#cfbafa";
      color13 = "#d4bfff";

      # aqua
      color6 = "#90e1c6";
      color14 = "#95e6cb";

      # white (fg4/fg3)
      color7 = "#c7c7c7";
      color15 = "#ffffff";
    };

    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+x" = "clear_terminal scroll active";
      "f11" = "toggle_fullscreen";
    };
  };
}
