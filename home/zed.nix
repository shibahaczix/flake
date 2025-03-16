{ pkgs, inputs, ... }:

{
  imports = [ inputs.chaotic.homeModules.default ];
  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor_git;
    extraPackages = with pkgs; [ nil nixd ];
    extensions = [ "nix" "toml" ];
    userSettings = {
      vim_mode = true;
      load_direnv = "shell_hook";
      theme = {
        mode = "dark";
        light = "Fleet Dark";
        dark = "Fleet Dark";
      };
      ui_font_size = 15;
      buffer_font_size = 15;
      hour_format = "hour24";
      auto_update = false;
      buffer_font_family = "JetBrainsMono Nerd Font";
      indent_guides = {
        enabled = true;
        line_width = 2;
        active_line_width = 2;
      };
      terminal = {
        env = { TERM = "kitty"; };
        font_family = "JetBrainsMono Nerd Font";
        line_height = "comfortable";
        shell = "system";
      };
    };
  };
}
