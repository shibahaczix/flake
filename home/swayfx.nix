{ pkgs, ... }:

{
  home.packages = with pkgs; [ grim slurp wl-clipboard wlr-randr vulkan-tools ];

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
    wrapperFeatures.gtk = true;
    checkConfig = false;
    config = {
      defaultWorkspace = "workspace number 1";

      output = {
        "*" = {
          bg = "~/flake/home/wallpapers/wallpaper1.jpg fill";
          max_render_time = "off";
          allow_tearing = "yes";
        };
        "HDMI-A-1" = {
          resolution = "1920x1080";
          position = "1920,0";
          mode = "1920x1080@72.808998Hz";
        };
      };

      bars = [ ];
      terminal = [ ];
      menu = [ ];

      window = {
        #border = 3;
        border = 2;
        titlebar = false;
      };

      #gaps = {
      #  inner = 9;
      #  outer = 2;
      #};

      input = {
        "*" = {
          xkb_layout = "pl";
          accel_profile = "flat";
          pointer_accel = "0";
        };
      };

      startup = [
        { command = "systemctl --user import-environment WAYLAND_DISPLAY"; }
        { command = "systemctl --user restart xdg-desktop-portal-wlr.service"; }
        { command = "gammastep output *"; }
      ];

      floating.modifier = "Mod4";

      focus.followMouse = true;

      keybindings = let
        mod = "Mod4";
        term = "kitty";
        menu = "fuzzel";
      in {
        "${mod}+Return" = "exec ${term}";
        "${mod}+space" = "exec ${menu}";

        # Kill, reload
        "${mod}+q" = "kill";
        "${mod}+Shift+c" = "reload";

        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";
        "${mod}+0" = "workspace number 10";

        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5";
        "${mod}+Shift+6" = "move container to workspace number 6";
        "${mod}+Shift+7" = "move container to workspace number 7";
        "${mod}+Shift+8" = "move container to workspace number 8";
        "${mod}+Shift+9" = "move container to workspace number 9";
        "${mod}+Shift+0" = "move container to workspace number 10";

        "${mod}+s" = "layout stacking";
        "${mod}+w" = "layout tabbed";
        "${mod}+e" = "layout toggle split";
        "${mod}+f" = "fullscreen";
        "${mod}+v" = "floating toggle";

        "Print" = ''exec grim -g "$(slurp)" -t png - | wl-copy -t image/png'';
        "${mod}+Print" =
          "exec grim -o HDMI-A-1 -t png - | wl-copy -t image/png";
      };

      colors = {
        focused = {
          border = "#5e81ac";
          background = "#3b4252";
          text = "#eceff4";
          indicator = "#88c0d0";
          childBorder = "#5e81ac";
        };

        unfocused = {
          border = "#4c566a";
          background = "#2e3440";
          text = "#d8dee9";
          indicator = "#81a1c1";
          childBorder = "#4c566a";
        };

        focusedInactive = {
          border = "#434c5e";
          background = "#2e3440";
          text = "#d8dee9";
          indicator = "#5e81ac";
          childBorder = "#434c5e";
        };

        urgent = {
          border = "#bf616a";
          background = "#3b4252";
          text = "#eceff4";
          indicator = "#bf616a";
          childBorder = "#bf616a";
        };
      };
    };

    extraConfig = ''
      shadows enable
      blur disable
      corner_radius 12
      for_window [app_id="kitty"] blur enable
    '';
  };

  services.mako = {
    enable = true;
    settings = {
      font = "JetBrainsMono NF 10";
      border-size = 4;
      border-radius = 5;
      border-color = "#95e6cbff";
      background-color = "#171717ff";
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
    latitude = 52.2;
    longitude = 18.2;
    temperature.day = 4000;
    temperature.night = 4000;
  };
}
