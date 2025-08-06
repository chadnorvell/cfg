{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
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
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-wsl,
      nix-darwin,
      nix-homebrew,
      homebrew-core,
      homebrew-cask,
      home-manager,
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
        };
      };

      nativeHost =
        hostName:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };

          modules = [
            baseConfig
            (import ./nixos.nix {
              inherit user;
              inherit hostName;
            })
            ./native/core.nix
            ./native/hosts/${hostName}.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${user} = {
                  imports = [ ./native/home.nix ];
                  home.username = user;
                  home.homeDirectory = nixosHomeDirectory;
                };
              };
            }
          ];
        };

      wslHost =
        hostName:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = inputs;

          modules = [
            baseConfig
            (import ./nixos.nix {
              inherit hostName;
              inherit user;
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
        nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = inputs;

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
        karuna = nativeHost "karuna";
        sunyata = nativeHost "sunyata";
        tahoma = wslHost "tahoma";
      };

      darwinConfigurations = {
        mazama = darwinHost "mazama";
      };
    };
}
