{pkgs, ...}: {
  home.packages = with pkgs; [tig];
  programs.git = {
    enable = true;
    userName = "shibahaczix";
    userEmail = "shibahaczix@gmail.com";
    signing = {
      format = "ssh";
      signByDefault = true;
      key = "~/.ssh/id_ed25519";
    };
    extraConfig.core.editor = "hx";
  };
}
