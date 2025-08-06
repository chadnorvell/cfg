{ config, ... }:

let
  homeDirectory = config.home.homeDirectory;
  configRoot = "${homeDirectory}/cfg/home";
  read = path: builtins.readFile "${configRoot}/${path}";
in
{
  imports = [
    ../../home/default.nix
    ./plasma.nix
  ];

  programs.kitty = {
    enable = true;
    extraConfig = read "kitty/kitty.conf";
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
  #
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

    kitty-borderless = {
      name = "Kitty (borderless)";
      exec = "kitty -o hide_window_decorations=yes";
      type = "Application";
      icon = "utilities-terminal";
      comment = "Fast, feature-rich, GPU based terminal";
      startupNotify = true;
      settings = {
        X-TerminalArgExec = "--";
        X-TerminalArgTitle = "--title";
        X-TerminalArgAppId = "--class";
        X-TerminalArgDir = "--working-directory";
        X-TerminalArgHold = "--hold";
      };
    };
  #
  #   neovide = {
  #     name = "Neovide";
  #     type = "Application";
  #     exec = "neovide %F";
  #     icon = "cxn-neovim";
  #     comment = "No Nonsense Neovim Client in Rust";
  #     categories = [
  #       "Development"
  #       "TextEditor"
  #       "Utility"
  #     ];
  #     mimeType = [
  #       "text/english"
  #       "text/plain"
  #       "text/x-makefile"
  #       "text/x-c++hdr"
  #       "text/x-c++src"
  #       "text/x-chdr"
  #       "text/x-csrc"
  #       "text/x-java"
  #       "text/x-moc"
  #       "text/x-pascal"
  #       "text/x-tcl"
  #       "text/x-tex"
  #       "application/x-shellscript"
  #       "text/x-c"
  #       "text/x-c++"
  #     ];
  #   };
  #
  #   obsidian = {
  #     name = "Obsidian";
  #     comment = "Knowledge base";
  #     exec = "obsidian %u";
  #     icon = "cxn-obsidian";
  #     type = "Application";
  #     categories = [ "Office" ];
  #     mimeType = [ "x-scheme-handler/obsidian" ];
  #   };
  };
}
