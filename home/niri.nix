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
      }
    '';
  };
}
