{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      nixos-hardware,
      nixos-wsl,
      nix-darwin,
      nix-homebrew,
      homebrew-core,
      homebrew-cask,
      home-manager,
      plasma-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      user = "chad";
      nixosHomeDirectory = "/home/${user}";
      darwinHomeDirectory = "/Users/${user}";

      baseConfig = {
        nix.settings.experimental-features = "nix-command flakes";

        nix.gc = {
          automatic = true;
          options = "--delete-older-than 7d";
        };

        nixpkgs.config = {
          allowUnfree = true;
          documentation = {
            enable = true;
            generateCaches = true;

            dev.enable = true;
            doc.enable = true;
            info.enable = true;
            man.enable = true;
            nixos.enable = true;
          };
        };
      };

      nativeHost =
        hostName: extraModules:
        nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";

          specialArgs = {
            inherit inputs outputs;

            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };

          modules = [
            baseConfig
            (import ./nixos.nix {
              inherit user;
              inherit hostName;
              extraGroups = [
                "docker"
                "networkmanager"
              ];
            })
            ./native/core.nix
            ./native/hosts/${hostName}.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                sharedModules = [ plasma-manager.homeModules.plasma-manager ];
                users.${user} = {
                  imports = [ ./native/home.nix ];
                  home.username = user;
                  home.homeDirectory = nixosHomeDirectory;
                };
              };
            }
          ]
          ++ extraModules;
        };

      wslHost =
        hostName:
        nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";

          specialArgs = {
            inherit inputs;

            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };

          modules = [
            baseConfig
            (import ./nixos.nix {
              inherit hostName;
              inherit user;
              extraGroups = [];
            })
            nixos-wsl.nixosModules.default
            {
              wsl.enable = true;
              wsl.defaultUser = user;
              wsl.interop.includePath = false;
            }
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${user} = {
                  imports = [ ../home/default.nix ];
                  home.username = user;
                  home.homeDirectory = nixosHomeDirectory;
                };
              };
            }
          ];
        };

      darwinHost =
        hostName:
        nix-darwin.lib.darwinSystem rec {
          system = "aarch64-darwin";

          specialArgs = {
            inherit inputs;

            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };

          modules = [
            baseConfig
            nix-homebrew.darwinModules.nix-homebrew
            (import ./darwin/core.nix { inherit user homebrew-core homebrew-cask; })
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${user} = {
                  imports = [ ./darwin/home.nix ];
                  home.username = user;
                  home.homeDirectory = darwinHomeDirectory;
                };
              };
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        advaita = wslHost "advaita";
        karuna = nativeHost "karuna" [ nixos-hardware.nixosModules.framework-amd-ai-300-series ];
        sunyata = nativeHost "sunyata" [ ];
        tahoma = wslHost "tahoma";
      };

      darwinConfigurations = {
        mazama = darwinHost "mazama";
      };
    };
}
