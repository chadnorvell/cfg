# CXN NixOS Configuration

## Setup on WSL

1. Install [NixOS-WSL](https://github.com/nix-community/NixOS-WSL).

2. Change the default hostname and
   [username](https://nix-community.github.io/NixOS-WSL/how-to/change-username.html)
   in `/etc/nixos/configuration.nix` to match the values in this configuration, then
   rebuild. In the `wsl -d NixOS --user root` step, instead of exiting immediately,
   set the user password.

3. Run `sudo nixos-rebuild switch --impure --flake ~/dev/nix`

## Setup on macOS

1. Install Nix using the
   [Determinate Nix installer](https://docs.determinate.systems/determinate-nix/),
   but only install normal Nix instead of Determinate Nix.

2. Install [nix-darwin](https://github.com/nix-darwin/nix-darwin) by running
   `sudo nix run nix-darwin/nix-darwin-25.05#darwin-rebuild -- switch --impure --flake ~/dev/nix`.
