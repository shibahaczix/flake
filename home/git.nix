{ pkgs, ... }:

{
  home.packages = with pkgs; [ tig ];

  programs.git = {
    enable = true;

    userName = "shibahaczix";
    userEmail = "shibahaczix@gmail.com";

    signing = {
      signByDefault = true;
      format = "ssh";
      key = "~/.ssh/id_ed25519";
    };

    extraConfig.core.editor = "hx";
  };
}
