{ pkgs, config, inputs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    settings = {
      general = {
        env = [
          "HYPRCURSOR_SIZE,24"
        ];
        gaps_in = "5";
        gaps_out = "10";

        border_size = "2";

        "col.inactive_border" = "rgba(595959aa)";
        "col.active_border" = "rgba(95E6CBff)";

        resize_on_border = false;

        allow_tearing = false;

        layout = "dwindle";
      };
      decoration = {
        rounding = "15";
        active_opacity = "1.0";
        inactive_opacity = "1.0";

        drop_shadow = true;
        shadow_range = "4";
        shadow_render_power = "3";

        blur = {
          enabled = true;
          size = "3";
          passes = "3";
        
          vibrancy = "0.1696";
        };
      };
      misc = {
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
      };
      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "hyprctl setcursor Babita-Modern-Classic 24"
        "wl-paste --type text --watch cliphist store #Stores only text data"
        "wl-paste --type image --watch cliphist store #Stores only image data"
      ];
      monitor = [ 
        "HDMI-A-1,1920x1080@60.00,0x0,1" 
	"LVDS-1,disable" 
      ];
      "$mod" = "SUPER";
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      bind = [
        "$mod, Return, exec, kitty"
        "$mod, Space, exec, fuzzel"
	"$mod, Q, killactive, "
	"$mod, V, togglefloating"
	"$mod, T, exec, hyprpicker -a --no-zoom"
	''$mod, C, exec, grim -g "$(slurp)"''
	"$mod, left, movefocus, l"
	"$mod, right, movefocus, r"
	"$mod, up, movefocus, u"
	"$mod, down, movefocus, d"
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );
    };
  };
}
