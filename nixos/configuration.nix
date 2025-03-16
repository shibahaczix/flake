{ pkgs, inputs, ... }:

{
  nix.package = pkgs.nixVersions.latest;
  nix = {
    settings = {
      trusted-users = [ "shiba" ];
      substituters =
        [ "https://nix-community.cachix.org" "https://cache.nixos.org/" ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports = [
    inputs.chaotic.nixosModules.default
    inputs.stylix.nixosModules.stylix
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "bcachefs" ];
  boot.kernelPackages = pkgs.linuxPackages_cachyos-lto;

  powerManagement.cpuFreqGovernor = "ondemand";

  services.scx.package = pkgs.scx_git.full;
  services.scx.enable = true; # by default uses scx_rustland scheduler

  # chaotic.mesa-git = {
  #   enable = true;
  #   extraPackages = with pkgs; [ intel-media-sdk ];
  # };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ intel-media-sdk ];
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

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
    # jack.enable = true;
  };

  users.users.shiba = {
    isNormalUser = true;
    description = "shiba";
    password = "123";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    # packages = with pkgs; [ ];
  };

  # QEMU
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Distrobox
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  security.sudo-rs.enable = true;
  security.sudo.enable = false;

  programs.nh = {
    enable = true;
    package = inputs.nh.packages.${pkgs.system}.default;
    clean.enable = true;
    clean.extraArgs = "--keep-since 1d --keep 3";
    flake = "/home/shiba/flake";
  };

  stylix = {
    enable = true;
    image = ./wallpaper.jpg;
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

  # Niri stuff
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };

  environment.systemPackages = with pkgs; [ uutils-coreutils-noprefix ];

  services.ratbagd.enable = true;

  programs.gamemode.enable = true;

  # For Sober
  services.flatpak.enable = true;

  # https://github.com/Riey/fontconfig-parser/pull/11
  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

  system.stateVersion = "25.05";
}
