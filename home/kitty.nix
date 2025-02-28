{ ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      enable_audio_bell = false;
      shell = "fish";
      confirm_os_window_close = 0;
      cursor_trail = 1;
      font_family = "JetBrainsMono NF";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      font_size = "11.5";
      background = "#212733";
      foreground = "#d9d7ce";
      cursor = "#ffcc66";
      selection_background = "#343f4c";
      color0 = "#191e2a";
      color8 = "#686868";
      color1 = "#ed8274";
      color9 = "#f28779";
      color2 = "#a6cc70";
      color10 = "#bae67e";
      color3 = "#fad07b";
      color11 = "#ffd580";
      color4 = "#6dcbfa";
      color12 = "#73d0ff";
      color5 = "#cfbafa";
      color13 = "#d4bfff";
      color6 = "#90e1c6";
      color14 = "#95e6cb";
      color7 = "#c7c7c7";
      color15 = "#ffffff";
      selection_foreground = "#212733";
      background_opacity = "0.0";
      window_border_width = "0px";
      tab_bar_margin_width = "0.0";
    };
    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+x" = "clear_terminal scroll active";
      "f11" = "toggle_fullscreen";
    };
  };
}
