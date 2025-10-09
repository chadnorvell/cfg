{ config, ... }:

let
  homeDirectory = config.home.homeDirectory;
  cfgRoot = "${homeDirectory}/cfg";
  cfgHomeRoot = "${cfgRoot}/home";
  symCfg = path: config.lib.file.mkOutOfStoreSymlink "${cfgRoot}/${path}";
  symHome = path: config.lib.file.mkOutOfStoreSymlink "${cfgHomeRoot}/${path}";

  customIcons = [
    "cxn-google-messages.svg"
    "cxn-whatsapp.svg"
  ];

  createCustomIconFiles = builtins.listToAttrs (
    map (f: {
      name = ".local/share/icons/${f}";
      value = {
        source = "${cfgRoot}/nix/native/icons/${f}";
      };
    }) customIcons
  );
in
{
  imports = [
    ../../home/default.nix
    ./plasma.nix
  ];

  home.file = {
    "media/images/wallpaper".source = symCfg "wallpaper";
  } // createCustomIconFiles;

  xdg.configFile."kitty".source = symHome "kitty";

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
    chrome-hpfldicfbfomlpcikngkocigghgafkph-Personal = {
      name = "Messages";
      type = "Application";
      terminal = false;
      exec = "google-chrome-stable --profile-directory=Personal --app-id=hpfldicfbfomlpcikngkocigghgafkph";
      icon = "cxn-google-messages";
      categories = [ "Network" ];
      settings = {
        StartupWMClass = "crx_hpfldicfbfomlpcikngkocigghgafkph";
      };
    };

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

    whatsie = {
      name = "WhatsApp";
      comment = "Feature rich WhatsApp Client for Desktop Linux";
      type = "Application";
      exec = "whatsie";
      icon = "cxn-whatsapp";
      categories = [ "Network" ];
    };
  };
}
