{ pkgs, config, inputs, lib, ... }:

{
  home.packages = with pkgs; [
    wl-clipboard
    wlr-randr
    vulkanPackages_latest.vulkan-tools
    swaybg
    xwayland-satellite-unstable
  ];

  imports = [ inputs.niri.homeModules.niri ];

  # blur https://github.com/YaLTeR/niri/pull/1634
  # hdr https://github.com/YaLTeR/niri/discussions/1128

  programs.niri = {
    package = pkgs.niri-unstable;
    settings = {
      spawn-at-startup = [{
        command = [
          "swaybg"
          "--image"
          "/home/shiba/flake/home/wallpapers/wallpaper1.jpg"
        ];
      }];
      outputs = {
        "DP-2" = {
          variable-refresh-rate = true;
          # allow-tearing not yet implemented https://github.com/YaLTeR/niri/issues/844
          mode = {
            width = 1920;
            height = 1080;
            refresh = 239.964005;
          };
        };
      };

      input = {
        mouse = { accel-profile = "flat"; };
        keyboard = { xkb = { layout = "pl"; }; };
      };

      hotkey-overlay.skip-at-startup = true;

      binds = with config.lib.niri.actions; {
        "Mod+Shift+Delete".action = show-hotkey-overlay;
        "Mod+Return".action.spawn = "${lib.getExe pkgs.kitty}";
        "Mod+Space".action.spawn = "${lib.getExe pkgs.fuzzel}";
        "Mod+C".action.screenshot = [ ];
        "Mod+Shift+C".action.screenshot-window = [ ];
        "Mod+V".action = toggle-window-floating;
        "Mod+Q".action = close-window;
        "Mod+F".action = maximize-column;
        "Mod+X".action = open-overview;
        "Mod+Shift+F".action = fullscreen-window;
        "Mod+S".action = set-column-width "50%";
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

        "Mod+H".action = focus-column-left;
        "Mod+L".action = focus-column-right;
        "Mod+J".action = focus-window-or-workspace-down;
        "Mod+K".action = focus-window-or-workspace-up;
        "Mod+Left".action = focus-column-left;
        "Mod+Right".action = focus-column-right;
        "Mod+Down".action = focus-workspace-down;
        "Mod+Up".action = focus-workspace-up;

        "Mod+Shift+H".action = move-column-left;
        "Mod+Shift+L".action = move-column-right;
        "Mod+Shift+K".action = move-column-to-workspace-up;
        "Mod+Shift+J".action = move-column-to-workspace-down;
      };

      prefer-no-csd = true;

      window-rules = [
        {
          draw-border-with-background = false;

          # geometry-corner-radius = let r = 11.5;
          # in {
          #   top-left = r;
          #   top-right = r;
          #   bottom-left = r;
          #   bottom-right = r;
          # };
          # clip-to-geometry = true;

          default-column-width.proportion = 1.0;

          focus-ring = {
            width = 2;
            inactive.color = "#7fc8ff";
            active.color = "#00ffff";
            urgent.color = "#9b0000";
          };

          shadow.enable = true;

        }
        {
          matches = [{ app-id = "^kitty$"; }];

          default-column-width.proportion = 0.5;
        }
      ];
      layout = {
        gaps = 10;
        preset-column-widths = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
          { proportion = 1.0; }
        ];
      };
    };
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
