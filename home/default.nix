{ config, ... }:

let
  homeDirectory = config.home.homeDirectory;
  configRoot = "${homeDirectory}/cfg/home";
  read = path: builtins.readFile "${configRoot}/${path}";
  sym = path: config.lib.file.mkOutOfStoreSymlink "${configRoot}/${path}";
in
{
  home.stateVersion = "25.05";
  home.sessionPath = [ "$HOME/.local/bin" ];

  programs.home-manager.enable = true;

  programs.bat = {
    enable = true;
    config.theme = "base16";
  };

  programs.btop = {
    enable = true;
    settings.color_theme = "onedark";
  };

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
    '';
  };

  xdg.configFile."fish/conf.d".source = sym "fish/conf.d";
  xdg.configFile."fish/functions".source = sym "fish/functions";

  programs.git = {
    enable = true;
    delta.enable = true;

    userName = "Chad Norvell";
    userEmail = "chadnorvell@pm.me";
    lfs.enable = true;

    aliases = {
      del-branches = "!git branch | cut -c 3- | gum choose --no-limit | xargs git branch -D";
      fixup-on = "!git log --oneline | gum filter | cut -d' ' -f1 | git commit --fixup";
      log1 = "log --oneline";
      logm = "log main..HEAD";
      logm1 = "log main..HEAD --oneline";
    };

    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };

  programs.neovim = {
    enable = true;

    extraLuaConfig = ''
      require("cxn")
    '';
  };

  xdg.configFile."nvim/lua" = {
    source = sym "nvim/lua";
    recursive = true;
  };

  programs.tmux = {
    enable = true;
    extraConfig = read "tmux/tmux.conf";
  };

  programs.vim = {
    enable = true;
    defaultEditor = true;
    extraConfig = read "vim/vimrc.vim";
  };

  programs.yazi = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = false;

    settings = {
      opener = {
        edit = [
          {
            run = "nvim \"$@\"";
            block = true;
          }
        ];
      };
    };
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = true;
  };
}
