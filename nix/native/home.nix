{ config, ... }:

let
  homeDirectory = config.home.homeDirectory;
  cfgRoot = "${homeDirectory}/cfg";
  cfgHomeRoot = "${cfgRoot}/home";
  symCfg = path: config.lib.file.mkOutOfStoreSymlink "${cfgRoot}/${path}";
  symHome = path: config.lib.file.mkOutOfStoreSymlink "${cfgHomeRoot}/${path}";
in
{
  imports = [
    ../../home/default.nix
    ./plasma.nix
  ];

  home.file."media/images/wallpaper".source = symCfg "wallpaper";

  xdg.configFile."hypr/conf".source = symHome "hypr/conf";
  xdg.configFile."kitty".source = symHome "kitty";
  xdg.configFile."shikane".source = symHome "shikane";
  xdg.configFile."sway/config.d".source = symHome "sway/config.d";
  xdg.configFile."swayidle".source = symHome "sway/swayidle";
  xdg.configFile."swaylock".source = symHome "sway/swaylock";
  xdg.configFile."waybar".source = symHome "waybar";

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

  wayland.windowManager.sway = {
    enable = true;
    package = null;
    config = null;
    extraConfig = ''
      include ~/.config/sway/config.d/*
    '';
  };
}
