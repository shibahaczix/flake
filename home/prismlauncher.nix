{ pkgs, inputs, ... }:

{
  home.packages = with pkgs;
    [
      (inputs.prismlauncher.packages.${pkgs.system}.prismlauncher.override {
        additionalPrograms = [ ffmpeg ];
        jdks = [ zulu8 zulu17 zulu graalvm-ce ];
      })
    ];
  home.file = {
    ".local/share/PrismLauncher/iconthemes".source = ./PrismLauncher/iconthemes;
    ".local/share/PrismLauncher/themes".source = ./PrismLauncher/themes;
  };
}
