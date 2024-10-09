{ ... }:

{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "kitty-direct";
        source = "/home/shiba/flake/home/fastfetch/image.png";
	      width = 22; #36
	      height = 10; #16
      };
      modules = [
        "title"
        "separator"
        "os"
        "kernel"
        "uptime"
        "packages"
        "disk"
        "colors"
      ];
    };
  };
}
