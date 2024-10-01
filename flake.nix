{
  description = "NixOS Flake for @wojciechdrabczyk's configs";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };
  outputs = {
    nixpkgs,
    nixos-wsl,
    vscode-server,
    home-manager,
    nixpkgs-unstable,
    ...
  } @ inputs: {
    devShells = {
      x86_64-linux.default = let
        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };
      in
        pkgs.mkShell {
          packages = with pkgs; [
            alejandra
            nil
          ];
        };
    };
    nixosConfigurations = let
      userConfig = {
        userName = "wojtek";
        fullName = "Wojciech Drabczyk";
        userEmail = "drabczyk@proton.me";
        root = true;
      };
      systemConfig = system: modules: prof:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
            inherit inputs userConfig;
          };
          inherit system;
          modules =
            [
              home-manager.nixosModules.home-manager
              (
                {...}: {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    users = {
                      "${userConfig.userName}" = import ./home;
                    };
                    extraSpecialArgs = {
                      inherit inputs prof userConfig;
                    };
                  };
                }
              )
              # Default module imported for all hosts
              ./modules/nixos/system.nix
              ./modules/dev
              ./modules/nixos/ssh.nix
            ]
            ++ modules;
        };
    in {
      # WSL host Nix modules
      wsl =
        systemConfig "x86_64-linux"
        [
          ./hosts/wsl/wsl.nix
          nixos-wsl.nixosModules.wsl
          vscode-server.nixosModules.default
          ./modules/nixvim
        ]
        # WSL host home modules
        [./home/common];
    };
  };
}
