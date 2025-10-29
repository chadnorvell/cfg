{ ... }:

{
  programs.plasma = {
    enable = true;

    shortcuts = {
      ksmserver = {
        "Lock Session" = "Meta+F12";
        "Log Out" = "Ctrl+Alt+Del";
      };

      kwin = {
        "Activate Window Demanding Attention" = "none";
        "Cycle Overview" = "none";
        "Cycle Overview Opposite" = "none";
        "Decrease Opacity" = "none";
        "Edit Tiles" = "none";
        "Expose" = "none";
        "ExposeAll" = "none";
        "ExposeClass" = "none";
        "ExposeClassCurrentDesktop" = "none";
        "Grid View" = "none";
        "Increase Opacity" = "none";
        "Kill Window" = "Meta+Shift+X";
        "Move Tablet to Next Output" = "none";
        "MoveMouseToCenter" = "none";
        "MoveMouseToFocus" = "none";
        "MoveZoomDown" = "none";
        "MoveZoomLeft" = "none";
        "MoveZoomRight" = "none";
        "MoveZoomUp" = "none";
        "Overview" = "none";
        "Show Desktop" = "none";
        "Switch One Desktop Down" = "none";
        "Switch One Desktop Up" = "none";
        "Switch One Desktop to the Left" = "none";
        "Switch One Desktop to the Right" = "none";
        "Switch Window Down" = "none";
        "Switch Window Left" = "none";
        "Switch Window Right" = "none";
        "Switch Window Up" = "none";
        "Switch to Desktop 1" = "Meta+Shift+1";
        "Switch to Desktop 2" = "Meta+Shift+2";
        "Switch to Desktop 3" = "Meta+Shift+3";
        "Switch to Desktop 4" = "Meta+Shift+4";
        "Switch to Desktop 5" = "Meta+Shift+5";
        "Switch to Desktop 6" = "Meta+Shift+6";
        "Switch to Desktop 7" = "Meta+Shift+7";
        "Switch to Desktop 8" = "Meta+Shift+8";
        "Switch to Desktop 9" = "Meta+Shift+9";
        "Walk Through Windows" = "Alt+Tab";
        "Walk Through Windows (Reverse)" = "Alt+Shift+Tab";
        "Walk Through Windows of Current Application" = "Alt+`";
        "Walk Through Windows of Current Application (Reverse)" = "Alt+~";
        "Window Close" = "Meta+X";
        "Window Fullscreen" = "Meta+Enter";
        "Window Maximize" = "none";
        "Window Minimize" = "none";
        "Window One Desktop Down" = "none";
        "Window One Desktop Up" = "none";
        "Window One Desktop to the Left" = "none";
        "Window One Desktop to the Right" = "none";
        "Window Operations Menu" = "none";
        "Window Quick Tile Bottom" = "none";
        "Window Quick Tile Left" = "none";
        "Window Quick Tile Right" = "none";
        "Window Quick Tile Top" = "none";
        "Window to Desktop 1" = "Meta+Ctrl+1";
        "Window to Desktop 2" = "Meta+Ctrl+2";
        "Window to Desktop 3" = "Meta+Ctrl+3";
        "Window to Desktop 4" = "Meta+Ctrl+4";
        "Window to Desktop 5" = "Meta+Ctrl+5";
        "Window to Desktop 6" = "Meta+Ctrl+6";
        "Window to Desktop 7" = "Meta+Ctrl+7";
        "Window to Desktop 8" = "Meta+Ctrl+8";
        "Window to Desktop 9" = "Meta+Ctrl+9";
        "Window to Next Screen" = "none";
        "Window to Previous Screen" = "none";
        "disableInputCapture" = "none";
        "view_actual_size" = "Meta+0";
        "view_zoom_in" = "Meta+=";
        "view_zoom_out" = "Meta+-";
      };

      plasmashell = {
        "activate application launcher" = "Meta+Esc";
        "activate task manager entry 1" = "Meta+0";
        "activate task manager entry 2" = "Meta+1";
        "activate task manager entry 3" = "Meta+2";
        "activate task manager entry 4" = "Meta+3";
        "activate task manager entry 5" = "Meta+4";
        "activate task manager entry 6" = "Meta+5";
        "activate task manager entry 7" = "Meta+6";
        "activate task manager entry 8" = "Meta+7";
        "activate task manager entry 9" = "Meta+8";
        "clipboard_action" = "none";
        "cycle-panels" = "none";
        "manage activities" = "none";
        "next activity" = "none";
        "previous activity" = "none";
        "show dashboard" = "none";
        "show-on-mouse-pos" = "none";
        "stop current activity" = "none";
      };

      "services/chromium-browser.desktop"."_launch" = "Meta+Shift+B";
      "services/google-chrome.desktop"."_launch" = "Meta+B";
      "services/kitty.desktop"."_launch" = "Meta+Z";
      "services/org.kde.dolphin.desktop"."_launch" = "Meta+F";
      "services/org.kde.plasma-systemmonitor.desktop"."_launch" = "none";
    };
  };
}
