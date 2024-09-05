{ pkgs, inputs, ... }: 

{
  programs.niri = {
    enable = true;
    #settings = {}; switch to it in the future
    config = ''
      spawn-at-startup "swww-daemon"
      spawn-at-startup "swww" "img" "/home/shiba/flake/home/wallpaper1.jpg"
      output "HDMI-A-1" {
        scale 1.0
        mode "1920x1080@71.910004"
      }
      output "LVDS-1" {
        off
      }
      binds {
        Mod+Space { spawn "fuzzel"; }

        Mod+Return { spawn "kitty"; }

        Mod+Shift+Delete { show-hotkey-overlay; }

        Mod+C { screenshot; }
        Mod+Q { close-window; }
        Mod+F { maximize-column; }

        Mod+J { spawn "swww" "img" "/home/shiba/flake/home/wallpaper1.jpg" "--transition-type" "center"; }
        Mod+K { spawn "swww" "img" "/home/shiba/flake/home/wallpaper2.jpg" "--transition-type" "center"; }
        Mod+L { spawn "swww" "img" "/home/shiba/flake/home/wallpaper3.jpg" "--transition-type" "center"; }

        Mod+Minus { set-column-width "-10%"; }
        Mod+Equal { set-column-width "+10%"; }

        Mod+Shift+Minus { set-column-width "-1"; }
        Mod+Shift+Equal { set-column-width "+1"; }

        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }

        Mod+Shift+1 { move-column-to-workspace 1; }
        Mod+Shift+2 { move-column-to-workspace 2; }
        Mod+Shift+3 { move-column-to-workspace 3; }
        Mod+Shift+4 { move-column-to-workspace 4; }
        Mod+Shift+5 { move-column-to-workspace 5; }
        Mod+Shift+6 { move-column-to-workspace 6; }
        Mod+Shift+7 { move-column-to-workspace 7; }
        Mod+Shift+8 { move-column-to-workspace 8; }
        Mod+Shift+9 { move-column-to-workspace 9; }
        Mod+Shift+WheelScrollDown      { focus-column-right; }
        Mod+Shift+WheelScrollUp        { focus-column-left; }
        Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
        Mod+Ctrl+Shift+WheelScrollUp   { move-column-left; }
      }

      prefer-no-csd

      window-rule {
        default-column-width { proportion 0.75; }
        min-width 100
        max-width 1920
        min-height 300
        max-height 1080
        open-maximized true
        geometry-corner-radius 12
        clip-to-geometry true
        draw-border-with-background false
        focus-ring {
          // off
          on
          width 4
          active-color "#7fc8ff"
          inactive-color "#505050"
          // active-gradient from="#80c8ff" to="#bbddff" angle=45
          // inactive-gradient from="#505050" to="#808080" angle=45 relative-to="workspace-view"
        }
      }
      animations {
        // off
        // slowdown 10.0
        // slowdown 4.0
        // slowdown 2.0
        // slowdown 1.5

        workspace-switch {
            // off
            spring damping-ratio=1.0 stiffness=1000 epsilon=0.0001
        }

        window-open {
            // off
            // duration-ms 2500
            // curve "ease-out-expo"
            // spring damping-ratio=0.8 stiffness=1000 epsilon=0.0001
        }

        window-close {
            // off
            // duration-ms 2500
            // curve "ease-out-cubic"
            // spring damping-ratio=0.8 stiffness=1000 epsilon=0.0001
        }

        horizontal-view-movement {
            // off
            // duration-ms 500
            // curve "ease-out-cubic"
            // spring damping-ratio=1.0 stiffness=20 epsilon=0.00001
            // spring damping-ratio=10.0 stiffness=800 epsilon=0.0001
        }

        window-movement {
            // off
            // duration-ms 750
            // curve "ease-out-cubic"
            // spring damping-ratio=1.0 stiffness=20 epsilon=0.00001
            // spring damping-ratio=0.2 stiffness=800 epsilon=0.0001
        }

        window-resize {
            // off
            // duration-ms 500
            // duration-ms 2500
            // curve "ease-out-cubic"
            // spring damping-ratio=0.2 stiffness=800 epsilon=0.0001

            custom-shader r"
                vec4 resize_color(vec3 coords_curr_geo, vec3 size_curr_geo) {
                    vec3 coords_next_geo = niri_curr_geo_to_next_geo * coords_curr_geo;
                    vec3 coords_prev_geo = niri_curr_geo_to_prev_geo * coords_curr_geo;

                    vec3 coords_crop = niri_geo_to_tex_next * coords_next_geo;
                    vec3 coords_stretch = niri_geo_to_tex_next * coords_curr_geo;
                    vec3 coords_stretch_prev = niri_geo_to_tex_prev * coords_curr_geo;

                    // We can crop if the current window size is smaller than the next window
                    // size. One way to tell is by comparing to 1.0 the X and Y scaling
                    // coefficients in the current-to-next transformation matrix.
                    bool can_crop_by_x = niri_curr_geo_to_next_geo[0][0] <= 1.0;
                    bool can_crop_by_y = niri_curr_geo_to_next_geo[1][1] <= 1.0;
                    bool crop = can_crop_by_x && can_crop_by_y;

                    vec4 color;

                    if (crop) {
                        // However, when we crop, we also want to crop out anything outside the
                        // current geometry. This is because the area of the shader is unspecified
                        // and usually bigger than the current geometry, so if we don't fill pixels
                        // outside with transparency, the texture will leak out.
                        //
                        // When stretching, this is not an issue because the area outside will
                        // correspond to client-side decoration shadows, which are already supposed
                        // to be outside.
                        if (coords_curr_geo.x < 0.0 || 1.0 < coords_curr_geo.x ||
                                coords_curr_geo.y < 0.0 || 1.0 < coords_curr_geo.y) {
                            color = vec4(0.0);
                        } else {
                            color = texture2D(niri_tex_next, coords_crop.st);
                        }
                    } else {
                        // If we can't crop, then crossfade.
                        color = texture2D(niri_tex_next, coords_stretch.st);
                        vec4 color_prev = texture2D(niri_tex_prev, coords_stretch_prev.st);
                        color = mix(color_prev, color, niri_clamped_progress);
                    }

                    return color;
                }
            "
        }

      config-notification-open-close {
          // off
          // duration-ms 250
          // curve "ease-out-cubic"
          // spring damping-ratio=0.1 stiffness=1000 epsilon=0.001
      }
  }
    '';
  };
}
