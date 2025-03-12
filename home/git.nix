{ pkgs, ... }:

{
  home.packages = with pkgs; [ tig ];
  programs.git = {
    enable = true;
    userName = "shibahaczix";
    userEmail = "shibahaczix@gmail.com";
    signing.format = "ssh";
    signing.signByDefault = true;
    extraConfig.user.signingkey = "~/.ssh/id_ed25519";
    extraConfig.core.editor = "hx";
  };
}
