{ pkgs-unstable, ... }:

{
  programs.hyprland = {
    enable = true;
    package = pkgs-unstable.hyprland;
    withUWSM = true;
    xwayland.enable = true;
  };
}
