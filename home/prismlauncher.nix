{pkgs, ...}: {
  home.packages = with pkgs; [
    (prismlauncher.override {
      jdks = [jdk8 jdk17 jdk21 temurin-jre-bin-24];
    })
  ];
  home.file = {
    ".local/share/PrismLauncher/iconthemes".source = ./PrismLauncher/iconthemes;
    ".local/share/PrismLauncher/themes".source = ./PrismLauncher/themes;
  };
}
