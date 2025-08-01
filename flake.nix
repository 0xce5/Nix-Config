{
  description = "0xCE5's Nix Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    jerry.url = "github:justchokingaround/jerry";
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nvf.url = "github:notashelf/nvf";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nix-autobahn.url = "github:Lassulus/nix-autobahn";
    impermanence.url = "github:nix-community/impermanence";

    # Hydenix and its nixpkgs - kept separate to avoid conflicts
    hydenix = {
      url = "github:richen604/hydenix";
    };
    zaphkiel.url = "github:Rexcrazy804/Zaphkiel";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming.url = "github:fufexan/nix-gaming";
    elyprism-launcher.url = "github:elyprismlauncher/elyprismlauncher";
  };

  outputs = {nixpkgs, ...} @ inputs: let
    HOSTNAME = "hydenix";

    hydenixConfig = inputs.hydenix.inputs.hydenix-nixpkgs.lib.nixosSystem {
      inherit (inputs.hydenix.lib) system;
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./configuration.nix
      ];
    };
  in {
    nixosConfigurations.nixos = hydenixConfig;
    nixosConfigurations.${HOSTNAME} = hydenixConfig;
  };
}
