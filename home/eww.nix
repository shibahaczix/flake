{ inputs, pkgs, ... }:

{
  programs.eww = {
    package = inputs.eww.packages.${pkgs.system}.eww;
    enable = true;
    configDir = ./eww;
  };
}
