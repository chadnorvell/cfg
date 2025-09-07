{ config, ... }:

let
  homeDirectory = config.home.homeDirectory;
  configRoot = "${homeDirectory}/cfg/home";
  read = path: builtins.readFile "${configRoot}/${path}";
  sym = path: config.lib.file.mkOutOfStoreSymlink "${configRoot}/${path}";
  jjExec = cmd: ["util" "exec" "--" "bash" "-c" cmd ""];
in
{
  home.stateVersion = "25.05";
  home.sessionPath = [ "$HOME/.local/bin" ];

  home.file.".local/bin/swaylock".source = sym "sway/swaylock/swaylock.sh";

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
      fixup-on = "!git log --oneline | gum choose | awk '{print $1}' | xargs git commit --fixup";
      log1 = "log --oneline";
      logm = "log main..HEAD";
      logm1 = "log main..HEAD --oneline";
      logt1 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'";
      logt2 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
      logt3 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset) %C(bold cyan)(committed: %cD)%C(reset) %C(auto)%d%C(reset)%n''          %C(white)%s%C(reset)%n''          %C(dim white)- %an <%ae> %C(reset) %C(dim white)(committer: %cn <%ce>)%C(reset)'";
      squash-all = "!f() { git reset $(git commit-tree HEAD^{tree} \"$@\"); }; f";
    };

    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };

  programs.jujutsu = {
    enable = true;

    settings = {
      user = {
        name = "Chad Norvell";
        email = "chadnorvell@pm.me";
      };

      ui.editor = "nvim";
      ui.paginate = "never";

      aliases = {
        c = ["commit"];
        d = ["describe"];
        mark = jjExec "jj bookmark create -r @ $1";
        "mark-" = jjExec "jj bookmark create -r @- $1";
        markAt = jjExec "jj bookmark create -r $1 $2";
        push = jjExec "jj git push --allow-new -b $1";
        pushAll = jjExec "jj git push --allow-new --all";
        "push!" = jjExec "jj git push -c @-";
        sync = jjExec "jj git fetch && jj rebase -d main@origin";
      };
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
