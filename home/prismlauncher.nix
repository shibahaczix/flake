{ pkgs, inputs, ... }:

{
  home.packages = with pkgs;
    [ inputs.prismlauncher.packages.${system}.default ];
  home.file = {
    ".local/share/PrismLauncher/iconthemes".source = ./PrismLauncher/iconthemes;
    ".local/share/PrismLauncher/themes".source = ./PrismLauncher/themes;
  };
}
