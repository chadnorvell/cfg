{
  user,
  homebrew-core,
  homebrew-cask,
}:
{ pkgs, ... }:

let
  darwinPkgs = with pkgs; [
    coreutils
  ];
in
{
  system.stateVersion = 6;
  system.primaryUser = "${user}";

  users.users.${user} = {
    name = user;
    home = "/Users/${user}";
    isHidden = false;
  };

  nix-homebrew = {
    inherit user;
    enable = true;
    mutableTaps = false;
    autoMigrate = true;

    taps = {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-cask" = homebrew-cask;
    };
  };

  environment.systemPackages = (import ../packages.nix { inherit pkgs; }) ++ darwinPkgs;
  fonts.packages = (import ../fonts.nix { inherit pkgs; });

  homebrew = {
    enable = true;

    casks = [
      "iterm2"
    ];
  };

  programs.fish.enable = true;
}
