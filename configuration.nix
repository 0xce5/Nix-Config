{
  inputs,
  lib,
  ...
}: let
  # Package declaration
  # ---------------------
  pkgs = import inputs.hydenix.inputs.hydenix-nixpkgs {
    inherit (inputs.hydenix.lib) system;
    config.allowUnfree = true;
    overlays = [
      inputs.hydenix.lib.overlays
      (final: prev: {
        userPkgs = inputs.nixpkgs {
          config.allowUnfree = true;
        };
      })
    ];
  };
in {
  # Set pkgs for hydenix globally, any file that imports pkgs will use this
  nixpkgs.pkgs = pkgs;

  imports = [
    inputs.hydenix.inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    inputs.hydenix.lib.nixOsModules
    ./modules/system

    # === GPU-specific configurations ===

    /*
    For drivers, we are leveraging nixos-hardware
    Most common drivers are below, but you can see more options here: https://github.com/NixOS/nixos-hardware
    */

    #! EDIT THIS SECTION
    # For NVIDIA setups
    inputs.hydenix.inputs.nixos-hardware.nixosModules.common-gpu-nvidia
    # inputs.hydenix.inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonmodeset

    # For AMD setups
    # inputs.hydenix.inputs.nixos-hardware.nixosModules.common-gpu-amd

    # === CPU-specific configurations ===
    # For AMD CPUs
    # inputs.hydenix.inputs.nixos-hardware.nixosModules.common-cpu-amd
    # inputs.hydenix.inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate

    # For Intel CPUs
    inputs.hydenix.inputs.nixos-hardware.nixosModules.common-cpu-intel

    # === Other common modules ===
    inputs.hydenix.inputs.nixos-hardware.nixosModules.common-pc
    inputs.hydenix.inputs.nixos-hardware.nixosModules.common-pc-ssd

    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  home-manager = {
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
    };

    #! EDIT THIS USER (must match users defined below)
    users."oxce5" = {...}: {
      imports = [
        inputs.hydenix.lib.homeModules
        ./modules/hm
      ];
    };
  };

  # IMPORTANT: Customize the following values to match your preferences
  hydenix = {
    enable = true; # Enable the Hydenix module

    #! EDIT THESE VALUES
    hostname = "hydenix"; # Change to your preferred hostname
    timezone = "Asia/Manila"; # Change to your timezone
    locale = "en_PH.UTF-8"; # Change to your preferred locale

    /*
    Optionally edit the below values, or leave to use hydenix defaults
    visit ./modules/hm/default.nix for more options
    */
    audio.enable = true; # enable audio module
    boot = {
      enable = true; # enable boot module
      useSystemdBoot = true; # disable for GRUBcpufreq
      grubTheme = pkgs.hydenix.grub-retroboot; # or pkgs.hydenix.grub-pochita
      grubExtraConfig = ""; # additional GRUB configuration
      kernelPackages = pkgs.linuxPackages_zen; # default zen kernel
    };
    hardware.enable = true; # enable hardware module
    network.enable = true; # enable network module
    nix.enable = true; # enable nix module
    sddm = {
      enable = true; # enable sddm module
      theme = "Candy"; # or pkgs.hydenix.sddm-corners
    };
    system.enable = true; # enable system module
  };

  #! EDIT THESE VALUES (must match users defined above)
  users.users.oxce5 = {
    isNormalUser = true; # Regular user account
    initialPassword = "hydenix"; # Default password (CHANGE THIS after first login with passwd)
    extraGroups = [
      "wheel" # For sudo access
      "networkmanager" # For network management
      "video" # For display/graphics access
      "docker"
      # Add other groups as needed
    ];
    shell = pkgs.zsh; # Change if you prefer a different shell
  };
  security.sudo.extraRules = [
    {
      users = ["oxce5"];
      commands = [
        {
          command = "ALL";
          options = ["NOPASSWD"]; # "SETENV" # Adding the following could be a good idea
        }
      ];
    }
  ];

  boot = {
<<<<<<< HEAD
    loader.systemd-boot.enable = lib.mkForce false;
=======
    loader = {
      timeout = 5;
      systemd-boot.configurationLimit = 3;
    };
>>>>>>> 5d9f851 (add: hyprlock rice)
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
    kernelModules = ["msr"];
<<<<<<< HEAD
=======
    extraModulePackages = [ config.boot.kernelPackages.lenovo-legion-module ];
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    plymouth = {
      enable = true;
    };
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
>>>>>>> 5d9f851 (add: hyprlock rice)
  };
}
