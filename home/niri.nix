{ pkgs, ... }: 

{
  programs.niri.settings = {
    outputs."HDMI-A-1".scale = 2.0;
  };
}
