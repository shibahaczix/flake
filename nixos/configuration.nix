{ pkgs, inputs, config, lib, ... }:

{
  nix.package = pkgs.nixVersions.latest;
  nix = {
    settings = {
      trusted-users = [ "shiba" ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
        "https://prismlauncher.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "prismlauncher.cachix.org-1:9/n/FGyABA2jLUVfY+DEp4hKds/rwO+SCOtbOkDzd+c="
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
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "bcachefs" ];
  boot.kernelPackages = pkgs.linuxPackages_cachyos-lto;

  # boot.initrd.kernelModules = [ "i915" ];
  boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" ];

  powerManagement.cpuFreqGovernor = "ondemand";

  # services.scx.package = pkgs.scx_git.full; # Broken
  services.scx.enable = true; # by default uses scx_rustland scheduler

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    modesetting.enable = true;
    nvidiaSettings = true;
    open = false;
  };

  boot.kernelParams = [ "pci=realloc" "rebar=1" ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
      "steam"
      "steam-original"
      "steam-unwrapped"
      "steam-run"
    ];

  console = {
    packages = with pkgs; [ terminus_font ];
    font = "ter-v32n";
    earlySetup = true;
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
    # description = "shiba";
    password = "123";
    extraGroups = [ "networkmanager" "wheel" ];
    # packages = with pkgs; [ ];
    shell = pkgs.fish;
    ignoreShellProgramCheck = true;
  };

  security.sudo-rs.enable = true;
  security.sudo.enable = false;

  programs.nh = {
    enable = true;
    package = inputs.nh.packages.${pkgs.system}.default;
    clean.enable = true;
    clean.dates = "weekly";
    clean.extraArgs = "--keep-since 1d --keep 3";
    flake = "/home/shiba/flake";
  };

  stylix = {
    enable = true;
    image = ./wallpaper.jpg;
    targets.console.enable = false;
  };

  programs.steam = { enable = true; };

  services.greetd = {
    enable = true;
    vt = 2;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet -r --cmd niri-session";
        user = "greeter";
      };
    };
  };

  programs.niri = {
    enable = true;
    package = inputs.niri.packages.${pkgs.system}.niri-unstable;
  };

  programs.ssh = {
    extraConfig = ''
      AddKeysToAgent yes
    '';
    # startAgent = true; # Niri conflict?
  };

  # programs.fish.enable = true; # Breaks hm

  environment.systemPackages = with pkgs; [ uutils-coreutils-noprefix ];

  services.ratbagd.enable = true;

  programs.gamemode.enable = true;

  system.stateVersion = "25.05";
}
