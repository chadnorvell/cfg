{ ... }:

{
  programs.plasma = {
    enable = true;

    kwin.scripts.polonium = {
      enable = true;
    };

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
        "PoloniumCycleEngine" = "Meta+|";
        "PoloniumFocusAbove" = "Meta+K";
        "PoloniumFocusBelow" = "Meta+J";
        "PoloniumFocusLeft" = "Meta+H";
        "PoloniumFocusRight" = "Meta+L";
        "PoloniumInsertAbove" = "Meta+Shift+K";
        "PoloniumInsertBelow" = "Meta+Shift+J";
        "PoloniumInsertLeft" = "Meta+Shift+H";
        "PoloniumInsertRight" = "Meta+Shift+L";
        "PoloniumResizeAbove" = "Meta+Ctrl+K";
        "PoloniumResizeBelow" = "Meta+Ctrl+J";
        "PoloniumResizeLeft" = "Meta+Ctrl+H";
        "PoloniumResizeRight" = "Meta+Ctrl+L";
        "PoloniumRetileWindow" = "Meta+Shift+Space";
        "PoloniumSwitchBTree" = "Meta+R";
        "PoloniumSwitchHalf" = "Meta+W";
        "PoloniumSwitchKwin" = "Meta+T";
        "PoloniumSwitchMonocle" = "Meta+Q";
        "PoloniumSwitchThreeColumn" = "Meta+E";
        "Show Desktop" = "none";
        "Switch One Desktop Down" = "none";
        "Switch One Desktop Up" = "none";
        "Switch One Desktop to the Left" = "none";
        "Switch One Desktop to the Right" = "none";
        "Switch Window Down" = "none";
        "Switch Window Left" = "none";
        "Switch Window Right" = "none";
        "Switch Window Up" = "none";
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Switch to Desktop 5" = "Meta+5";
        "Switch to Desktop 6" = "Meta+6";
        "Switch to Desktop 7" = "Meta+7";
        "Switch to Desktop 8" = "Meta+8";
        "Switch to Desktop 9" = "Meta+9";
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
        "Window to Desktop 1" = "Meta+Shift+1";
        "Window to Desktop 2" = "Meta+Shift+2";
        "Window to Desktop 3" = "Meta+Shift+3";
        "Window to Desktop 4" = "Meta+Shift+4";
        "Window to Desktop 5" = "Meta+Shift+5";
        "Window to Desktop 6" = "Meta+Shift+6";
        "Window to Desktop 7" = "Meta+Shift+7";
        "Window to Desktop 8" = "Meta+Shift+8";
        "Window to Desktop 9" = "Meta+Shift+9";
        "Window to Next Screen" = "none";
        "Window to Previous Screen" = "none";
        "disableInputCapture" = "none";
        "view_actual_size" = "Meta+0";
        "view_zoom_in" = "Meta+=";
        "view_zoom_out" = "Meta+-";
      };

      plasmashell = {
        "activate application launcher" = "Meta+Esc";
        "activate task manager entry 1" = "none";
        "activate task manager entry 2" = "none";
        "activate task manager entry 3" = "none";
        "activate task manager entry 4" = "none";
        "activate task manager entry 5" = "none";
        "activate task manager entry 6" = "none";
        "activate task manager entry 7" = "none";
        "activate task manager entry 8" = "none";
        "activate task manager entry 9" = "none";
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
