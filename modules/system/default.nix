{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    # ./example.nix - add your modules here
    inputs.nix-flatpak.nixosModules.nix-flatpak

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
    # pkgs.vscode - hydenix's vscode version
    # pkgs.userPkgs.vscode - your personal nixpkgs version
  ];

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
  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 5";
      flake = "/home/oxce5/hydenix/";
    };
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
      enable = false;
      systemCronJobs = [
        "*/5 * * * * ~/duckdns/duck.sh >/dev/null 2>&1"
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
