{ ... }: {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "kitty-direct";
        source = "/home/shiba/flake/home/fastfetch/image.png";
        width = 23;
        height = 10;
      };
      modules = [
        "title"
        "separator"
        {
          type = "os";
          key = "{#separator} {#keys}󰍹 OS";
        }
        {
          type = "kernel";
          key = "{#separator} {#keys}󰒋 Kernel";
        }
        {
          type = "uptime";
          key = "{#separator} {#keys}󰅐 Uptime";
        }
        {
          type = "packages";
          key = "{#separator} {#keys}󰏖 Packages";
          format = "{all}";
        }
        {
          type = "disk";
          key = "{#separator} {#keys}󰋊 Disk (/)";
          folders = "/";
        }
        "colors"
      ];
    };
  };
}
