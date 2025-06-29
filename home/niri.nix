{ config, pkgs, lib, inputs, ... }:

{
  # WM related
  imports = [ inputs.niri.homeModules.niri ];

  home.packages = with pkgs; [
    swww
    wl-clipboard
    wayland-utils
    wlr-randr
    inputs.niri.packages.${system}.xwayland-satellite-unstable
    swaylock-effects
  ];

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

  # programs.eww = {
  #   package = inputs.eww.packages.${pkgs.system}.eww;
  #   enable = true;
  #   configDir = ./eww;
  # };

  services.gammastep = {
    enable = true;
    provider = "manual";
    # Desktop
    latitude = 52.2;
    longitude = 18.2;
  };

  home.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.niri = {
    # Enabled in NixOS to make screensharing work
    package = inputs.niri.packages.${pkgs.system}.niri-unstable;
    settings = {
      spawn-at-startup = [
        {
          command = [ "swww-daemon" ];
        }
        # { command = [ "eww" "open" "bar" ]; }
        {
          command =
            [ "swww" "img" "/home/shiba/flake/home/wallpapers/wallpaper1.jpg" ];
        }
        { command = [ "xwayland-satellite" ]; }
      ];
      outputs = {
        "HDMI-A-1" = {
          mode = {
            width = 1920;
            height = 1080;
            refresh = 71.910004;
          };
        };
        "LVDS-1" = { enable = false; };
      };

      input = {
        mouse = { accel-profile = "flat"; };
        keyboard = { xkb = { layout = "pl"; }; };
      };

      hotkey-overlay.skip-at-startup = true;

      binds = with config.lib.niri.actions;
        let sh = spawn "sh" "-c";
        in {
          "Mod+Shift+Delete".action = show-hotkey-overlay;
          "Mod+Return".action.spawn = "${lib.getExe pkgs.kitty}";
          "Mod+Space".action.spawn = "${lib.getExe pkgs.fuzzel}";
          "Mod+Delete".action = sh ''
            niri msg action do-screen-transition --delay-ms 300
            swaylock \
              --clock \
              --screenshots \
              --daemonize \
              --ignore-empty-password \
              --font "Ubuntu Bold" \
              --indicator \
              --indicator-radius 150 \
              --effect-scale 0.4 \
              --effect-vignette 0.2:0.5 \
              --effect-blur 4x2 \
              --datestr "%A, %b %d" \
              --timestr "%k:%M" \
              --key-hl-color 61768ff2 \
              --ring-color 61768ff2 \
              --text-color ffffffe6 \
              --inside-clear-color 0b0b0cf2 \
              --ring-clear-color 61768ff2 \
              --text-clear-color ffffffe6 \
              --inside-ver-color 0b0b0cf2 \
              --ring-ver-color 61768ff2 \
              --text-ver-color ffffffe6 \
              --bs-hl-color 3c3836ff \
              --inside-wrong-color c30505ff \
              --ring-wrong-color c30505ff \
              --text-wrong-color ffffffff
          '';
          "Mod+C".action = screenshot;
          "Mod+V".action = toggle-window-floating;
          "Mod+Shift+C".action = screenshot-window;
          "Mod+Q".action = close-window;
          "Mod+F".action = maximize-column;
          "Mod+X".action = open-overview;
          "Mod+Minus".action = set-column-width "-10%";
          "Mod+Equal".action = set-column-width "+10%";
          "Mod+Shift+Minus".action = set-window-height "-10%";
          "Mod+Shift+Equal".action = set-window-height "+10%";
          "Mod+WheelScrollDown".action = focus-column-right;
          "Mod+WheelScrollUp".action = focus-column-left;
          "Mod+Shift+WheelScrollDown".action = move-column-right;
          "Mod+Shift+WheelScrollUp".action = move-column-left;
          "Mod+1".action = focus-workspace 1;
          "Mod+2".action = focus-workspace 2;
          "Mod+3".action = focus-workspace 3;
          "Mod+4".action = focus-workspace 4;
          "Mod+5".action = focus-workspace 5;
          "Mod+6".action = focus-workspace 6;
          "Mod+7".action = focus-workspace 7;
          "Mod+8".action = focus-workspace 8;
          "Mod+9".action = focus-workspace 9;
          "Mod+shift+1".action = move-column-to-index 1;
          "Mod+shift+2".action = move-column-to-index 2;
          "Mod+shift+3".action = move-column-to-index 3;
          "Mod+shift+4".action = move-column-to-index 4;
          "Mod+shift+5".action = move-column-to-index 5;
          "Mod+shift+6".action = move-column-to-index 6;
          "Mod+shift+7".action = move-column-to-index 7;
          "Mod+shift+8".action = move-column-to-index 8;
          "Mod+shift+9".action = move-column-to-index 9;
        };
      environment = {
        DISPLAY = ":0"; # xwayland-satellite
      };
      prefer-no-csd = true;
      window-rules = [{
        draw-border-with-background = false;

        geometry-corner-radius = let r = 11.5;
        in {
          top-left = r;
          top-right = r;
          bottom-left = r;
          bottom-right = r;
        };
        clip-to-geometry = true;

        default-column-width.proportion = 1.0;

        focus-ring = {
          inactive.color = "#50505040";
          active.color = "#EDDBFFee";
        };

        shadow.enable = true;

      }];
      layout = {
        gaps = 6;
        preset-column-widths = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
          { proportion = 1.0; }
        ];
      };
    };
  };
}
