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

  systemd.user.services.devlog-gen = {
    Unit = {
      Description = "Generate dev log summary";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.fish}/bin/fish -lc 'devlog_gen'";
    };
  };

  systemd.user.timers.devlog-gen = {
    Unit = {
      Description = "Periodically generate dev log summary";
    };
    Timer = {
      OnCalendar = "hourly";
      Persistent = true;
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };

  systemd.user.services.git-sync-org = {
    Unit.Description = "Git sync org repo";
    Service = {
      Type = "oneshot";
      ExecStart = toString (
        pkgs.writeShellScript "git-sync-org" ''
          cd /home/chad/org || exit 1
          git fetch --all
          dirty=$(git diff --quiet && git diff --cached --quiet; echo $?)
          if [ "$dirty" != "0" ]; then
            git stash push --include-untracked -m "git-sync-auto"
          fi
          git pull --rebase
          git push
          if [ "$dirty" != "0" ]; then
            git stash pop
          fi
        ''
      );
    };
  };

  systemd.user.timers.git-sync-org = {
    Unit.Description = "Periodically git sync org repo";
    Timer = {
      OnCalendar = "*:0/5";
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];
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
