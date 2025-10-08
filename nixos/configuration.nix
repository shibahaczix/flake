{ pkgs, inputs, config, ... }: {
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

  imports =
    [ inputs.chaotic.nixosModules.default ./hardware-configuration.nix ];

  boot.loader.limine.enable = true;
  boot.loader.limine.efiSupport = true;
  boot.loader.limine.style.wallpapers = [ (builtins.toString ./craft.jpg) ];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_cachyos-lto;

  powerManagement.cpuFreqGovernor = "ondemand";

  boot.initrd.systemd.enable = true;

  #hardware.graphics = {
  #  enable = true;
  #  enable32Bit = true;
  #  extraPackages = [ pkgs.rocmPackages.clr.icd ]
  #};
  #environment.variables.AMD_VULKAN_ICD = "RADV";
  hardware.amdgpu.overdrive.enable = true;
  chaotic.mesa-git.enable = true;

  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  boot.kernelParams =
    [ "radeon.si_support=0" "amdgpu.si_support=1" "pci=realloc" "rebar=1" ];
  hardware.amdgpu.overdrive.ppfeaturemask = "0xffffffff";

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

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.dates = "weekly";
    clean.extraArgs = "--keep-since 1d --keep 3";
    flake = "/home/shiba/flake";
  };

  programs.steam = { enable = true; };

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "dbus-run-session ${pkgs.swayfx}/bin/sway";
        user = "shiba";
      };
      default_session = initial_session;
    };
  };

  environment.variables = {
    QT_QPA_PLATFORM = "wayland";
    XDG_CURRENT_DESKTOP = "sway";
    NIXOS_OZONE_WL = "1";
    GDK_BACKEND = "wayland";
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

  programs.dconf.enable = true; # needed for sway
  xdg.portal = {
    enable = true;
    wlr.enable = true; # provides screen share
    config.common.default = [ "wlr" ];
  };

  security.sudo-rs.enable = true;
  security.sudo.enable = false;

  programs.ssh = {
    extraConfig = ''
      AddKeysToAgent yes
    '';
    #startAgent = true;
  };

  # programs.fish.enable = true; # Breaks hm

  environment.systemPackages = with pkgs; [
    (pkgs.gamescope_git.overrideAttrs (oldAttrs: {
      patches = (oldAttrs.patches or [ ])
        ++ [ ./e07c32c6684b56bf969e22a9f04e6a2c1dd95061.diff ];
    }))
    lact
    uutils-coreutils-noprefix
  ];
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];

  services.ratbagd.enable = true;

  programs.gamemode.enable = true;

  services.flatpak.enable = true;

  nixpkgs.config.allowUnfree = true;

  hardware.cpu.amd.updateMicrocode =
    config.hardware.enableRedistributableFirmware;
  system.stateVersion = config.system.nixos.release;
}
