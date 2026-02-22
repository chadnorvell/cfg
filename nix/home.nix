{
  config,
  lib,
  pkgs,
  ...
}:

let
  homeDirectory = config.home.homeDirectory;

  addToPath = [
    "${homeDirectory}/.local/bin"
    "${homeDirectory}/.cargo/bin"
  ];
in
{
  home.stateVersion = "25.11";
  home.sessionPath = [
    "${homeDirectory}/.local/bin"
    "${homeDirectory}/.cargo/bin"
  ];

  systemd.user.sessionVariables = {
    EDITOR = "nvim";
    GOPATH = "${homeDirectory}/pkg/go";
    MAKEFLAGS = "-j20";
    npm_config_prefix = "${homeDirectory}/.local";
    PATH = lib.strings.concatStringsSep ":" addToPath + ":$PATH";
  };

  programs.home-manager.enable = true;

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
    '';
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = true;
  };

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

  systemd.user.services.grasp-backend = {
    Unit = {
      Description = "Grasp backend for org-capture browser extension";
    };
    Service = {
      ExecStart = "${pkgs.grasp-backend}/bin/grasp_backend serve --path ${homeDirectory}/org/weblog/weblog.org";
      Restart = "always";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
