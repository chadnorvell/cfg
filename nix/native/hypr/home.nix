{ config, ... }:

let
  homeDirectory = config.home.homeDirectory;
  configRoot = "${homeDirectory}/cfg/nix/native/hypr/config";
  sym = path: config.lib.file.mkOutOfStoreSymlink "${configRoot}/${path}";
  hyprlandConfigDir = "${homeDirectory}/.config/hypr/hyprland";
in
{
  xdg.configFile."hypr/hyprland".source = sym "hypr";
  xdg.configFile."waybar".source = sym "waybar";

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;

    extraConfig = ''
      source = ${hyprlandConfigDir}/monitors.conf
      source = ${hyprlandConfigDir}/autostart.conf
      source = ${hyprlandConfigDir}/env.conf
      source = ${hyprlandConfigDir}/look.conf
      source = ${hyprlandConfigDir}/input.conf
      source = ${hyprlandConfigDir}/bindings.conf
      source = ${hyprlandConfigDir}/rules/general.conf
    '';
  };
}
