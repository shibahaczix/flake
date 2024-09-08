{ pkgs, ... }:

{
  home.packages = with pkgs; [
    prismlauncher
  ];
  home.file = {
    ".local/share/PrismLauncher/iconthemes".source = ./PrismLauncher/iconthemes; 
    ".local/share/PrismLauncher/themes".source = ./PrismLauncher/themes; 
  };
}
