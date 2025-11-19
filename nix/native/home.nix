{ config, ... }:

let
  homeDirectory = config.home.homeDirectory;
  cfgRoot = "${homeDirectory}/cfg";
  cfgHomeRoot = "${cfgRoot}/home";
  symCfg = path: config.lib.file.mkOutOfStoreSymlink "${cfgRoot}/${path}";
  symHome = path: config.lib.file.mkOutOfStoreSymlink "${cfgHomeRoot}/${path}";

  customIcons = [
    "cxn-google-chat.svg"
    "cxn-google-messages.svg"
    "cxn-whatsapp-web.png"
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
    ../../home/plasma.nix
  ];

  home.file = {
    "media/images/wallpaper".source = symCfg "wallpaper";
  } // createCustomIconFiles;

  programs.walker = {
    enable = true;
    runAsService = true;
    config = {};
  };

  wayland.windowManager.sway = {
    enable = true;
    package = null;
    config = null;

    extraConfig = ''
      include ~/.config/sway/config.d/*
    '';
  };

  xdg.configFile."elephant/menus".source = symHome "elephant/menus";
  xdg.configFile."kitty".source = symHome "kitty";
  xdg.configFile."shikane".source = symHome "shikane";
  xdg.configFile."sway/config.d".source = symHome "sway/config.d";
  xdg.configFile."swayidle".source = symHome "sway/swayidle";
  xdg.configFile."swaylock".source = symHome "sway/swaylock";
  xdg.configFile."walker".source = symHome "walker";
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
    chrome-hpfldicfbfomlpcikngkocigghgafkph-Personal = {
      name = "Google Messages";
      type = "Application";
      terminal = false;
      exec = "google-chrome-stable --profile-directory=Personal --app-id=hpfldicfbfomlpcikngkocigghgafkph";
      icon = "cxn-google-messages";
      categories = [ "Network" ];
      settings = {
        StartupWMClass = "crx_hpfldicfbfomlpcikngkocigghgafkph";
      };
    };

    chrome-mdpkiolbdkhdjpekfbkbmhigcaggjagi-Constructural = {
      name = "Google Chat";
      type = "Application";
      terminal = false;
      exec = "google-chrome-stable --profile-directory=Constructural --app-id=mdpkiolbdkhdjpekfbkbmhigcaggjagi";
      icon = "cxn-google-chat";
      categories = [ "Network" ];
      settings = {
        StartupWMClass = "crx_mdpkiolbdkhdjpekfbkbmhigcaggjagi";
      };
    };

    chrome-hnpfjngllnobngcgfapefoaidbinmjnm-Personal = {
      name = "WhatsApp";
      type = "Application";
      terminal = false;
      exec = "google-chrome-stable --profile-directory=Personal --app-id=hnpfjngllnobngcgfapefoaidbinmjnm";
      icon = "cxn-whatsapp-web";
      categories = [ "Network" ];
      settings = {
        StartupWMClass = "crx_hnpfjngllnobngcgfapefoaidbinmjnm";
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
  };
}
