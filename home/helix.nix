{ pkgs, inputs, ... }:

{
  programs.helix = {
    enable = true;
    package = inputs.helix.packages."${pkgs.system}".default;
    settings = {
      keys = {
        normal = {
          C-right = "move_next_word_end";
          C-left = "move_prev_word_start";
          C-backspace = "delete_word_backward";
          C-r = "redo";
          p = [ "paste_clipboard_after" "collapse_selection" ];
          P = [ "paste_clipboard_before" "collapse_selection" ];
          Y = [
            "extend_to_line_end"
            "yank_main_selection_to_clipboard"
            "collapse_selection"
          ];
          y = {
            y = [
              "extend_to_line_bounds"
              "yank_main_selection_to_clipboard"
              "normal_mode"
              "collapse_selection"
            ];
          };

          S-up = [ ];
          S-down = [ ];

        };
        select = {
          C-right = "move_next_word_end";
          C-left = "move_prev_word_start";
          y = [
            "yank_main_selection_to_clipboard"
            "normal_mode"
            "flip_selections"
            "collapse_selection"
          ];
          Y = [
            "extend_to_line_bounds"
            "yank_main_selection_to_clipboard"
            "goto_line_start"
            "collapse_selection"
            "normal_mode"
          ];
          p = "replace_selections_with_clipboard";
          P = "paste_clipboard_before";
          S-up = [ ];
          S-down = [ ];
          "<" = [
            "extend_to_line_bounds"
            "save_selection"
            "unindent"
            "select_mode"
            "jump_backward"
            "shrink_to_line_bounds"
          ];
          ">" = [
            "extend_to_line_bounds"
            "save_selection"
            "indent"
            "select_mode"
            "jump_backward"
            "extend_to_line_bounds"
          ];
          d = [ "yank_main_selection_to_clipboard" "delete_selection" ];
          esc = [ "collapse_selection" "keep_primary_selection" "normal_mode" ];
        };
        insert = {
          C-right = "move_next_word_end";
          C-left = "move_prev_word_start";
          C-backspace = "delete_word_backward";
        };
      };
      theme = "amberwood"; # fleet_dark
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
      editor.indent-guides = {
        character = "│";
        render = true;
      };
      editor.lsp = {
        display-inlay-hints = true;
        display-messages = true;
      };
      editor = { line-number = "relative"; };
    };
    languages.language = [{
      name = "nix";
      auto-format = true;
      formatter.command = "${pkgs.nixfmt-classic}/bin/nixfmt";
    }];
    extraPackages = with pkgs; [ nil nixd ];
  };
}
