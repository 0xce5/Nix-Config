{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  imports = [
    # ./example.nix - add your modules here
    inputs.spicetify-nix.homeManagerModules.default
    inputs.nix-index-database.hmModules.nix-index
<<<<<<< HEAD
=======
    inputs.zen-browser.homeModules.twilight
    inputs.impermanence.homeManagerModules.impermanence
    inputs.zen-nebula.homeModules.default
>>>>>>> 5d9f851 (add: hyprlock rice)

    ./hyprlock.nix
    ./nvf_config.nix
  ];

  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      hidePodcasts
      shuffle # shuffle+ (special characters are sanitized out of extension names)
    ];
    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus
      reddit
    ];
    theme = spicePkgs.themes.hazy;
  };
  programs.yazi.enable = true;
  programs.lazygit.enable = true;
  programs.gh.enable = true;

  # home-manager options go here/
<<<<<<< HEAD
  home.packages = with pkgs; [
    inputs.zen-browser.packages."${system}".default
=======
  programs = { 
    lazygit.enable = true;
    gh.enable = true;
    zen-browser = {
      enable = true;
    };
    zellij = {
      enable = true;
      enableZshIntegration = true;
    };
    nh = {
      enable = true;
      clean.enable = if config.programs.nh.enable then true else false;
      clean.extraArgs = "--keep-since 4d --keep 5";
      flake = "/home/oxce5/hydenix/";
    };
  };
  zen-nebula = {
    enable = true;
    profile = "wgi9he2k.Default Profile";
  };

  services = {
    podman.enable = true;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/roblox-player" = [ "org.vinegarhq.Sober.desktop" ];
    };
  };

  home.packages = with pkgs; [
    trackma-curses
    heroic
    bottles
    blender
    (GPUOffloadApp blender "blender")
    zoxide
>>>>>>> 5d9f851 (add: hyprlock rice)
    krita
    clang
    mpv
    obs-studio
    tealdeer
    blender
    motrix
    # pkgs.vscode - hydenix's vscode version
    # pkgs.userPkgs.vscode - your personal nixpkgs version
  ];
<<<<<<< HEAD
  home.file = {
    ".config/hypr/userprefs.conf" = lib.mkForce {
      source = ./config/userprefs.conf;
      force = true;
      mutable = true;
    };
    ".config/hypr/keybindings.conf" = lib.mkForce {
      source = ./config/keybindings.conf;
      force = true;
      mutable = true;
    };
    "${config.xdg.configHome}/mimeapps.list".force = lib.mkForce true;
    ".config/kitty/theme.conf" = lib.mkForce {
      source = ./config/theme.conf;
      force = true;
      mutable = true;
    };
    ".config/kitty/kitty.conf" = lib.mkForce {
      source = ./config/kitty.conf;
      force = true;
      mutable = true;
    };
    ".config/hyde/themes/Tokyo Night/wallpapers/carlotta.jpg" = lib.mkForce {
      source = ./assets/carlotta.jpg;
      force = true;
      mutable = true;
    };
  };
  services.podman.enable = true;

=======
  home.persistence."/persistent" = {
    directories = [
      ".zen"
    ];
  };
  
>>>>>>> 5d9f851 (add: hyprlock rice)
  # hydenix home-manager options go here
  hydenix.hm = {
    #! Important options
    enable = true;

    /*
    ! Below are defaults
    */
    comma.enable = true; # useful nix tool to run software without installing it first
    dolphin.enable = true; # file manager
    editors = {
      enable = true; # enable editors module
      vscode = {
        enable = false; # enable vscode module
        wallbash = true; # enable wallbash extension for vscode
      };
      default = "nvim"; # default text editor
    };

    fastfetch.enable = true; # fastfetch configuration
    firefox = {
      enable = false; # enable firefox module
    };
    git = {
      enable = true; # enable git module
      name = "oxce5"; # git user name eg "John Doe"
      email = "avg.gamer@proton.me"; # git user email eg "john.doe@example.com"
    };
    hyde.enable = true; # enable hyde module
    hyprland.enable = true; # enable hyprland module
    lockscreen = {
      enable = false; # enable lockscreen module
      hyprlock = false; # enable hyprlock lockscreen
      swaylock = false; # enable swaylock lockscreen
    };
    notifications.enable = true; # enable notifications module
    qt.enable = true; # enable qt module
    rofi.enable = true; # enable rofi module
    screenshots = {
      enable = true; # enable screenshots module
      grim.enable = true; # enable grim screenshot tool
      slurp.enable = true; # enable slurp region selection tool
      satty.enable = false; # enable satty screenshot annotation tool
      swappy.enable = true; # enable swappy screenshot editor
    };
    shell = {
      enable = true; # enable shell module
      zsh.enable = true; # enable zsh shell
      zsh.configText = ''
        alias rebuild="/home/oxce5/hydenix/scripts/nixos-rebuild.sh"
        alias nvim="/home/oxce5/hydenix/scripts/nvim.sh"

        f=~/hydenix/scripts/nh-comp.sh
        [[ -f "$f" ]] && source "$f"
      ''; # zsh config text
      zsh.plugins = [ "sudo" ];
      bash.enable = false; # enable bash shell
      fish.enable = false; # enable fish shell
      pokego.enable = true; # enable Pokemon ASCII art scripts
      p10k.enable = false; # enable p10k prompt
      starship.enable = true; # enable starship prompt
    };
    social = {
      enable = true; # enable social module
      discord.enable = true; # enable discord module
      webcord.enable = false; # enable webcord module
      vesktop.enable = false; # enable vesktop module
    };
    spotify.enable = false; # enable spotify module
    swww.enable = true; # enable swww wallpaper daemon
    terminals = {
      enable = true; # enable terminals module
      kitty.enable = true; # enable kitty terminal
      kitty.configText = "
        background_opacity 0.4
      "; # kitty config text
    };
    theme = {
      enable = true; # enable theme module
<<<<<<< HEAD
      active = "Tokyo Night"; # active theme name
=======
      active = "Oxo Carbon"; # active theme name
>>>>>>> 5d9f851 (add: hyprlock rice)
      themes = [
        "Oxo Carbon"
        "Tokyo Night"
        "Material Sakura"
        "Catppuccin Mocha"
      ]; # default enabled themes, full list in https://github.com/richen604/hydenix/tree/main/hydenix/sources/themes
    };
    waybar.enable = false; # enable waybar module
    wlogout.enable = true; # enable wlogout module
    xdg.enable = true; # enable xdg module
  };
}
