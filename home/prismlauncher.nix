{ pkgs, ... }:

{
  home.packages = with pkgs; [
    prismlauncher
  ];
  home.file.".local/share/PrismLauncher".source = ./PrismLauncher; 
}
