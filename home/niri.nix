{
  pkgs,
  config,
  inputs,
  lib,
  ...
}:

{
  home.packages = with pkgs; [
    wl-clipboard
    wlr-randr
    vulkanPackages_latest.vulkan-tools
    clinfo
    wayland-utils
    swaybg
    xwayland-satellite-unstable
  ];

  imports = [ inputs.niri.homeModules.niri ];

  # blur https://github.com/YaLTeR/niri/pull/1634
  # hdr https://github.com/YaLTeR/niri/discussions/1128

  programs.niri = {
    package = pkgs.niri-unstable;
    settings = {
      spawn-at-startup = [
        {
          command = [
            "swaybg"
            "--image"
            "/home/shiba/flake/home/wallpapers/wallpaper.png"
          ];
        }
      ];
      outputs = {
        "DP-1" = {
          variable-refresh-rate = true;
          # explicit sync https://github.com/YaLTeR/niri/pull/1449
          # tearing https://github.com/YaLTeR/niri/issues/844
          mode = {
            width = 1920;
            height = 1080;
            refresh = 239.964005;
          };
        };
      };

      input = {
        mouse = {
          accel-profile = "flat";
        };
        keyboard = {
          xkb = {
            layout = "pl";
          };
        };
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

        "Mod+WheelScrollDown".action = focus-column-right;
        "Mod+WheelScrollUp".action = focus-column-left;

        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        "Mod+5".action = focus-workspace 5;
        "Mod+6".action = focus-workspace 6;
        "Mod+7".action = focus-workspace 7;
        "Mod+8".action = focus-workspace 8;
        "Mod+9".action = focus-workspace 9;
      };

      prefer-no-csd = true;

      window-rules = [
        {
          draw-border-with-background = false;

          default-column-width.proportion = 1.0;

          focus-ring = {
            width = 2;
            inactive.color = "#7fc8ff";
            active.color = "#b9aeda";
            urgent.color = "#9b0000";
          };

          shadow.enable = true;

        }
        {
          matches = [ { app-id = "^kitty$"; } ];

          default-column-width.proportion = 0.5;
        }
        {
          matches = [ { app-id = "^zen-beta$"; } ];

          block-out-from = "screencast";
        }
        {
          matches = [ { app-id = "^discord$"; } ];

          block-out-from = "screencast";

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
      border-size = 2;
      border-color = "#b9aedaff";
      background-color = "#11111bff";
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
      border.radius = 0;
      colors.background = "11111bff";
      colors.border = "b9aedaff";
      colors.text = "b9aedaff";
      colors.selection = "#b9aedaff";
      colors.selection-text = "#11111bff";
      border.width = 2;
    };
  };
}
