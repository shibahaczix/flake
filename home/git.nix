{ pkgs, ... }:

{
  home.packages = with pkgs; [ tig ];
  programs.git = {
    enable = true;
    userName = "shibahaczix";
    userEmail = "shibahaczix@gmail.com";
    extraConfig.core.editor = "hx";
    signing.format = "ssh";
    extraConfig.user.signingkey = "~/.ssh/id_ed25519";
  };
}
