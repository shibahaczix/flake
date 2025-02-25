{ pkgs, inputs, ... }:

{
  home.packages = with pkgs;
    [
      (inputs.prismlauncher.packages.${pkgs.system}.prismlauncher.override {
        additionalPrograms = [ ];
        jdks = [ jre8 jre17 jre21 temurin-jre-bin ];
      })
    ];
  home.file = {
    ".local/share/PrismLauncher/iconthemes".source = ./PrismLauncher/iconthemes;
    ".local/share/PrismLauncher/themes".source = ./PrismLauncher/themes;
  };
}
