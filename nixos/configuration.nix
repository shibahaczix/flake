{ config, pkgs, lib, ... }:

{
  nix = {
    settings = {
      trusted-users = [ "shiba" ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
 
  imports = [
    ./hardware-configuration.nix
  ]; 

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "bcachefs" ];
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  chaotic.scx.enable = true; # by default uses scx_rustland scheduler
  chaotic.mesa-git.enable = true;

  programs.auto-cpufreq.enable = true;

  programs.auto-cpufreq.settings = {
    charger = {
      governor = "ondemand";
      turbo = "auto";
    };
    battery = {
      governor = "powersave";
      turbo = "auto";
    };
  };

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "Europe/Warsaw";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  security.rtkit.enable = true;
  services.pipewire = {
    wireplumber.enable = true;
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  users.users.shiba = {
    isNormalUser = true;
    description = "shiba";
    password = "123";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  # Issue with git on nixos-rebuild
  #security.doas = {
  #  enable = true;
  #  extraRules = [{
  #    users = ["shiba"];
  #    keepEnv = true; 
  #    persist = true;
  #  }];
  #};
  #security.sudo.enable = false;

  #programs.nh = {
  #  enable = true;
  #  clean.enable = true;
  #  clean.extraArgs = "--keep-since 4d --keep 3";
  #  flake = "/home/shiba/flake";
  #};

  system.autoUpgrade = {
   enable = true;
   dates = "*-*-* 04:00:00";
   persistent = true;
   allowReboot = true;
  };

  nix.gc = {
   automatic = true;
   persistent = false;
   dates = "daily";
   options = "--delete-older-than 7d";
  };

  stylix = {
    enable = true;
    image = /home/shiba/flake/nixos/wallpaper.jpg;
  };

  xdg.portal = {
    enable = true;
    wlr = {
      enable = true;
      settings = {
        screencast = {
          output_name = "HDMI-A-1";
          max_fps = 60;
          #exec_before = "disable_notifications.sh";
          #exec_after = "enable_notifications.sh";
          chooser_type = "simple";
          chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
        };
      };
    };
    extraPortals = with pkgs; [ xdg-desktop-portal xdg-desktop-portal-gnome xdg-desktop-portal-wlr xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      # Add additional package names here
      "steam"
      "steam-original"
      "steam-run"
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  programs.gamemode.enable = true;

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ]; })
  ];

  environment.systemPackages = [
    pkgs.uutils-coreutils-noprefix
  ];

  # I USE IT FOR SOBER
  services.flatpak.enable = true;

  system.stateVersion = "24.05";

}
