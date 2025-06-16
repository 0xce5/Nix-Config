{
  inputs,
  pkgs,
<<<<<<< HEAD
=======
  config,
  lib,
>>>>>>> 5d9f851 (add: hyprlock rice)
  ...
}: {
  imports = [
    # ./example.nix - add your modules here
    inputs.nix-flatpak.nixosModules.nix-flatpak
<<<<<<< HEAD
=======
    inputs.sops-nix.nixosModules.sops
    inputs.hydenix.inputs.nixos-hardware.nixosModules.common-gpu-nvidia
>>>>>>> 5d9f851 (add: hyprlock rice)

    ./aagl.nix
  ];

  environment.systemPackages = with pkgs; [
    inputs.jerry.packages.${pkgs.system}.default
    sbctl
    waydroid-helper
    cloudflare-warp
    unrar
    p7zip
    python3Full
    wine
    alejandra
    bat
<<<<<<< HEAD
=======
    nix-ld
    nextdns

    python313Packages.aria2p
>>>>>>> 5d9f851 (add: hyprlock rice)
    # pkgs.vscode - hydenix's vscode version
    # pkgs.userPkgs.vscode - your personal nixpkgs version
  ];

<<<<<<< HEAD
=======
  specialisation = {
    battery-saver.configuration = {
      system.nixos.tags = ["battery-saver"];
      hardware = {
        nvidia = {
          prime.offload.enable = lib.mkForce false;
          prime.offload.enableOffloadCmd = lib.mkForce false;
          powerManagement.finegrained = lib.mkForce false;
        };
      };
    };
  };

  hardware.sane.enable = true; # enables support for SANE scanners
>>>>>>> 5d9f851 (add: hyprlock rice)
  hardware.graphics = {
    enable = true;
  };
  hardware.nvidia = {
    open = false;
    powerManagement.finegrained = true;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
<<<<<<< HEAD
=======
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.cpu.intel.updateMicrocode = true; # update Intel CPU microcode

>>>>>>> 5d9f851 (add: hyprlock rice)
  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
<<<<<<< HEAD
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 5";
      flake = "/home/oxce5/hydenix/";
    };
=======
    nix-ld = {
      enable = true;
      libraries = pkgs.steam-run.args.multiPkgs pkgs;
    }; 
    gamemode.enable = true;
>>>>>>> 5d9f851 (add: hyprlock rice)
  };
  services = {
    thermald.enable = true;
    auto-cpufreq.enable = true;
    auto-cpufreq.settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
    tlp = {
      enable = true;
      settings.CPU_MAX_PERF_ON_BAT = 30;
<<<<<<< HEAD
=======
      settings.CPU_MAX_PERF_ON_AC = 100;
>>>>>>> 5d9f851 (add: hyprlock rice)
    };
    undervolt = {
      enable = true;
      coreOffset = -125;
    };

    deluge = {
      enable = true;
      web.enable = true;
      user = "oxce5";
    };

    flatpak = {
      enable = true;
      packages = [
        "com.github.tchx84.Flatseal"
        "com.usebottles.bottles"
        "io.mrarm.mcpelauncher"
      ];
    };
    cron = {
      enable = true;
      systemCronJobs = [
        "*/20 * * * * /home/0xce5/hydenix/scripts/weather.sh /tmp/hyprlock-weather.txt >/dev/null 2>&1"
      ];
    };
    nextdns = {
      enable = true;
      arguments = [
        "-config" "9a438c"
        "-cache-size" "10MB"
      ];
    };
  };
  systemd.services.flatpak-repo = {
    wantedBy = ["multi-user.target"];
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
  systemd.services.nextdns-activate = {
    script = ''
      /run/current-system/sw/bin/nextdns activate
    '';
    after = [ "nextdns.service" ];
    wantedBy = [ "multi-user.target" ];
  };

  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
    waydroid.enable = true;
  };

  networking = {
    firewall = {
      enable = true;
      allowedUDPPorts = [19132 19133];
    };
  };

  systemd.packages = [pkgs.cloudflare-warp]; # for warp-cli
  systemd.targets.multi-user.wants = ["warp-svc.service"]; # causes warp-svc to be started automatically
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };
  nix.settings = {
    substituters = ["https://ezkea.cachix.org"];
    trusted-public-keys = ["ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="];
  };
}
