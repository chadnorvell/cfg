{ config, ... }:

let
  homeDirectory = config.home.homeDirectory;
  configRoot = "${homeDirectory}/cfg/home";
  sym = path: config.lib.file.mkOutOfStoreSymlink "${configRoot}/${path}";
  hyprlandConfigDir = "${homeDirectory}/.config/hypr/conf";
in
{
  imports = [
    ../../home/default.nix
    ./plasma.nix
  ];

  xdg.configFile."hypr/conf".source = sym "hypr/conf";
  xdg.configFile."kitty".source = sym "kitty";
  xdg.configFile."waybar".source = sym "waybar";

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "${homeDirectory}/top";
    documents = "${homeDirectory}/docs";
    download = "${homeDirectory}/inbox";
    music = "${homeDirectory}/media/music";
    pictures = "${homeDirectory}/media/images";
    publicShare = "${homeDirectory}/pub";
    templates = "${homeDirectory}/docs/templates";
    videos = "${homeDirectory}/media/videos";
  };

  xdg.desktopEntries = {
    kitty = {
      name = "Kitty";
      exec = "kitty";
      type = "Application";
      icon = "utilities-terminal";
      comment = "Fast, feature-rich, GPU based terminal";
      startupNotify = true;
      categories = [
        "Development"
        "System"
        "TerminalEmulator"
      ];
      settings = {
        X-TerminalArgExec = "--";
        X-TerminalArgTitle = "--title";
        X-TerminalArgAppId = "--class";
        X-TerminalArgDir = "--working-directory";
        X-TerminalArgHold = "--hold";
      };
    };
  };

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
