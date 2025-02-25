{ pkgs, inputs, ... }:

{
  home.packages = with pkgs;
    [
      (inputs.prismlauncher.packages.${pkgs.system}.prismlauncher.override {
        # additionalPrograms = [ ];
        # jdks = [ ];
      })
    ];
  home.file = {
    ".local/share/PrismLauncher/iconthemes".source = ./PrismLauncher/iconthemes;
    ".local/share/PrismLauncher/themes".source = ./PrismLauncher/themes;
  };
}
