{
  pkgs,
  inputs,
  lib,
  ...
}: {
  nix.package = pkgs.nixVersions.latest;
  nix = {
    settings = {
      trusted-users = ["shiba"];
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
  nix.settings.experimental-features = ["nix-command" "flakes"];

  imports = [
    inputs.chaotic.nixosModules.default
    inputs.stylix.nixosModules.stylix
    #inputs.fht-compositor.nixosModules.default
    ./hardware-configuration.nix
  ];

  boot.loader.limine.enable = true;
  boot.loader.limine.efiSupport = true;
  boot.loader.limine.style.wallpapers = [
    (builtins.toString ./craft.jpg)
  ];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_cachyos-lto;

  powerManagement.cpuFreqGovernor = "ondemand";

  #hardware.graphics = {
  #  enable = true;
  #  enable32Bit = true;
  #};
  #environment.variables.AMD_VULKAN_ICD = "RADV";
  chaotic.mesa-git.enable = true;

  #boot.initrd.kernelModules = ["amdgpu"];
  #services.xserver.enable = true;
  #services.xserver.videoDrivers = ["amdgpu"];
  boot.kernelParams = ["radeon.si_support=0" "amdgpu.si_support=1" "pci=realloc" "rebar=1"];
  #hardware.graphics.extraPackages = with pkgs; [
  #  amdvlk
  #];
  #hardware.graphics.extraPackages32 = with pkgs; [
  #  driversi686Linux.amdvlk
  #];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-unwrapped"
      "steam-run"
    ];

  console = {
    packages = with pkgs; [terminus_font];
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
    extraGroups = ["networkmanager" "wheel"];
    # packages = with pkgs; [ ];
    shell = pkgs.fish;
    ignoreShellProgramCheck = true;
  };

  programs.nh = {
    enable = true;
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

  programs.steam = {
    enable = true;
  };

  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      package = pkgs.swayfx;
    };
    xwayland.enable = true;
  };

  services.displayManager.ly.enable = true;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    wlr.enable = true;
    config = {
      common = {
        default = ["wlr"];
      };
      sway = {
        default = ["gtk"];
      };
    };
  };

  programs.ssh = {
    extraConfig = ''
      AddKeysToAgent yes
    '';
    #startAgent = true;
  };

  # programs.fish.enable = true; # Breaks hm

  environment.systemPackages = with pkgs; [
    (pkgs.gamescope_git.overrideAttrs
      (oldAttrs: {patches = (oldAttrs.patches or []) ++ [./e07c32c6684b56bf969e22a9f04e6a2c1dd95061.diff];}))
    lact
  ];
  systemd.packages = with pkgs; [lact];
  systemd.services.lactd.wantedBy = ["multi-user.target"];
  #programs.fht-compositor.enable = true;

  services.ratbagd.enable = true;

  programs.gamemode.enable = true;

  services.flatpak.enable = true;

  system.stateVersion = "25.05";
}
