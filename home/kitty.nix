{ pkgs, ... }: {
  programs.kitty = {
    enable = true;

    package = (pkgs.callPackage ./kitty-42.2.nix { });
    # Fixed a "bug" that makes background opacity linear
    # which forces me to use built in kitty blur and opacity
    # instead of my compositor opacity and blur.
    # https://github.com/kovidgoyal/kitty/tree/linear
    # https://github.com/kovidgoyal/kitty/issues/8869
    # https://github.com/kovidgoyal/kitty/issues/9073
    # https://sw.kovidgoyal.net/kitty/changelog/#id2
    # https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.background_opacity

    font = {
      name = "JetBrainsMono NF";
      size = 11.5;
    };

    settings = {
      shell = "fish";

      enable_audio_bell = false;

      confirm_os_window_close = 0;

      cursor_trail = 1;

      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      cursor = "#ffcc66";

      background = "#212733";
      foreground = "#d9d7ce";

      selection_background = "#343f4c";
      selection_foreground = "#212733";

      background_opacity = "0.0";

      window_border_width = "0px";
      tab_bar_margin_width = "0.0";

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

