{ pkgs, inputs, ... }: 

{
  programs.niri = {
    enable = true;
    #settings = {
    #  outputs."HDMI-A-1".scale = 2.0;
    #  window-rule = {
    #    geometry-corner-radius = 12;
    #    clip-to-geometry = true;
    #  };
    #  binds = {
    #    "Mod+D".action.spawn = "fuzzel";
    #    "Mod+1".action.focus-workspace = 1;
    #  };
    #};
    config = ''
      output "HDMI-A-1" {
        scale 1.0
      }
      binds {
        Mod+Space { spawn "fuzzel"; }
        Mod+Return { spawn "kitty"; }
        Mod+C { screenshot; }
        Mod+Q { close-window; }
        Mod+F { maximize-column; }
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
    '';
  };
}
