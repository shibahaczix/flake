{
  pkgs,
  inputs,
  config,
  ...
}:

{

  nix.package = pkgs.nixVersions.latest;
  nix = {
    settings = {
      download-buffer-size = 250000000;
      auto-optimise-store = true;

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
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  imports = [
    inputs.chaotic.nixosModules.default
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_cachyos-lto-znver4;

  powerManagement.cpuFreqGovernor = "schedutil";

  hardware.amdgpu.overdrive.enable = true;
  hardware.amdgpu.initrd.enable = true;

  boot.initrd.systemd.enable = true;

  chaotic.mesa-git.enable = true;
  chaotic.mesa-git.extraPackages = with pkgs; [
    rocmPackages.clr.icd
    ocl-icd

    vulkanPackages_latest.vulkan-loader
    vulkanPackages_latest.vulkan-validation-layers
    vulkanPackages_latest.vulkan-extension-layer
  ];

  boot.kernelParams = [
    "pci=realloc"
    "rebar=1"
    "amdgpu.ppfeaturemask=0xffffffff"
    "transparent_hugepage=madvise"
    "nowatchdog"
    "nohz_full=1"
    "mitigations=auto"
  ];

  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642;
    "vm.vfs_cache_pressure" = 30;
    "vm.dirty_ratio" = 20;
    "vm.dirty_background_ratio" = 10;
    "vm.dirty_writeback_centisecs" = 3000;
    "vm.dirty_expire_centisecs" = 6000;
  };

  systemd.tmpfiles.rules = [ "w /sys/kernel/mm/transparent_hugepage/shmem_enabled - - - - advise" ];

  console = {
    packages = with pkgs; [ terminus_font ];
    font = "ter-v32n";
    earlySetup = true;
  };

  networking = {
    useNetworkd = true; # systemd-networkd is faster at startup by default and more actively maintained
    hostName = "nixos";
    wireless.enable = false; # no wpa_supplicant needed for an ethernet connection
  };

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
    password = "123";
    extraGroups = [
      "wheel"
    ];

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

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.niri-unstable}/bin/niri-session";
        user = "shiba";
      };
    };
  };

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  fonts = {
    packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "JetBrainsMono NF" ];
        sansSerif = [ "JetBrainsMono NF" ];
        serif = [ "JetBrainsMono NF" ];
      };
    };
  };

  services.lact.enable = true;

  services.ratbagd.enable = true;

  programs.gamemode.enable = true;

  programs.steam.enable = true;

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = config.system.nixos.release;
}
