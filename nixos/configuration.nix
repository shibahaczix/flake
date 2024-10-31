{ config, pkgs, lib, inputs, ... }:

{
  nix = {
    settings = {
      trusted-users = [ "shiba" ];
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
        "https://prismlauncher.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "prismlauncher.cachix.org-1:9/n/FGyABA2jLUVfY+DEp4hKds/rwO+SCOtbOkDzd+c="
      ];
    };
  };

  imports = [
    inputs.chaotic.nixosModules.default
    inputs.auto-cpufreq.nixosModules.default
    inputs.stylix.nixosModules.stylix
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "bcachefs" ];
  boot.kernelPackages = pkgs.linuxPackages_cachyos-rc;
  chaotic.scx.enable = true; # By default uses scx_rustland scheduler
  chaotic.mesa-git.enable = true;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ ];
  };

  programs.auto-cpufreq = {
    enable = true;
    settings = {
      charger = {
        governor = "ondemand";
        turbo = "auto";
      };
      battery = {
        governor = "powersave";
        turbo = "auto";
      };
    };
  };

  networking.hostName = "nixos";
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
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [ ];
  };

  # QEMU
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  system.autoUpgrade = {
    enable = true;
    dates = "*-*-* 04:00:00";
    persistent = true;
    allowReboot = true;
  };

  nix.settings.auto-optimise-store = true;
  #nix.gc = {
  #  automatic = true;
  #  dates = "daily";
  #  options = "--delete-older-than 1d";
  #};

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 1d --keep 3";
    flake = "/home/shiba/flake";
  };

  security.doas.enable = true;
  security.sudo.enable = false;

  stylix = {
    enable = true;
    image = ./wallpaper.jpg;
  };

  # niri-flake
  services.gnome.gnome-keyring.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };

  services.greetd = {
    enable = true;
    vt = 2;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd niri-session";
        user = "greeter";
      };
    };
  };

  programs.gamemode.enable = true;

  services.ratbagd.enable = true;

  environment.systemPackages = with pkgs; [ uutils-coreutils-noprefix ];

  # For packages enabled in home/packages
  nixpkgs.config = {
    permittedInsecurePackages = [ "cinny-unwrapped-4.2.2" "cinny-4.2.2" ];
    allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "steam-unwrapped"
        "steam"
        "steam-original"
        "steam-run"
      ];
  };

  system.stateVersion = "24.05";
}
