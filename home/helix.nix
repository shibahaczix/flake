{ pkgs, ... }: {
  programs.helix = {
    enable = true;
    package = pkgs.evil-helix;
    settings = {
      keys = {
        normal = { };
        insert = { };
        select = { };
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
