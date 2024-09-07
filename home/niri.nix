{ config, pkgs, lib, inputs, ... }: 

{
  imports = [
    inputs.niri.homeModules.niri
  ];

  home.packages = with pkgs; [
    swww
    xwayland-run
    wl-clipboard
    wlr-randr
  ];

  services.cliphist.enable = true;

  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = 52.2;
    longitude = 18.2;
  };

  programs.niri = {
    enable = true;
    settings = {
      spawn-at-startup = [
        { command = [ "swww-daemon" ]; }
        { command = [ "swww" "img" "/home/shiba/flake/home/wallpapers/wallpaper1.jpg" ]; }
      ];
      outputs."HDMI-A-1" = {
        mode = {
          width = 1920;
          height = 1080;
          refresh = 71.910004;
        };
      };
      outputs."LVDS-1" = {
        enable = false;
      };
      hotkey-overlay.skip-at-startup = true;
      binds = 
        with config.lib.niri.actions;
        let
        in
      {
        "Mod+Shift+Delete".action = show-hotkey-overlay;
        "Mod+Return".action.spawn = "${lib.getExe pkgs.kitty}";
        "Mod+Space".action.spawn = "${lib.getExe pkgs.fuzzel}";
        "Mod+C".action = screenshot;
        "Mod+Q".action = close-window;
        "Mod+F".action = maximize-column;
        "Mod+J".action = spawn "swww" "img" "/home/shiba/flake/home/wallpapers/wallpaper1.jpg" "--transition-type" "center";
        "Mod+K".action = spawn "swww" "img" "/home/shiba/flake/home/wallpapers/wallpaper2.jpg" "--transition-type" "center";
        "Mod+L".action = spawn "swww" "img" "/home/shiba/flake/home/wallpapers/wallpaper3.jpg" "--transition-type" "center";
        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Equal".action = set-column-width "+10%";
        "Mod+Shift+Minus".action = set-window-height "-10%";
        "Mod+Shift+Equal".action = set-window-height "+10%";
        "Mod+Shift+WheelScrollDown".action = focus-column-right;
        "Mod+Shift+WheelScrollUp".action = focus-column-left;
        "Mod+Ctrl+Shift+WheelScrollDown".action = move-column-right;
        "Mod+Ctrl+Shift+WheelScrollUp".action = move-column-left;
        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        "Mod+5".action = focus-workspace 5;
        "Mod+6".action = focus-workspace 6;
        "Mod+7".action = focus-workspace 7;
        "Mod+8".action = focus-workspace 8;
        "Mod+9".action = focus-workspace 9;
        "Mod+shift+1".action = move-column-to-workspace 1;
        "Mod+shift+2".action = move-column-to-workspace 2;
        "Mod+shift+3".action = move-column-to-workspace 3;
        "Mod+shift+4".action = move-column-to-workspace 4;
        "Mod+shift+5".action = move-column-to-workspace 5;
        "Mod+shift+6".action = move-column-to-workspace 6;
        "Mod+shift+7".action = move-column-to-workspace 7;
        "Mod+shift+8".action = move-column-to-workspace 8;
        "Mod+shift+9".action = move-column-to-workspace 9;
      };
      prefer-no-csd = true;
      window-rules = [
        {
          draw-border-with-background = false;
          geometry-corner-radius =
            let
              r = 8.0;
            in
            {
              top-left = r;
              top-right = r;
              bottom-left = r;
              bottom-right = r;
            };
          clip-to-geometry = true;
        }
      ];
      layout.border = {
        inactive.color = "rgb(80 80 80)";
        active.color = "rgb(80 80 80)";
      };
    }; 
  };
}
