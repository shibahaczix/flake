{ pkgs, ... }:

{
  home.packages = with pkgs; [
    prismlauncher
  ];
  home.file.".local/share/PrismLauncher/iconthemes".source = ./PrismLauncher/iconthemes; 
  home.file.".local/share/PrismLauncher/themes".source = ./PrismLauncher/themes; 
}
