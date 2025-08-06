{ config, ... }:

let
  homeDirectory = config.home.homeDirectory;
in
{
  imports = [
    ../../home/default.nix
    ./iterm2.nix
  ];

  programs.iterm2 = {
    enable = true;
    settings.appearance.theme = "minimal";

    profiles = [
      {
        name = "Default";
        default = true;

        font = {
          normal = "IosevkaNFM 16";
          antiAlias = true;
          brightenBold = true;
        };

        colors = {
          foreground = "#d8dee9";
          background = "#343d46";

          black = {
            normal = "#000000";
            bright = "#808080";
          };

          red = {
            normal = "#ec5f66";
            bright = "#f97b58";
          };

          green = {
            normal = "#99c794";
            bright = "#acd1a8";
          };

          yellow = {
            normal = "#f9ae58";
            bright = "#fac761";
          };

          blue = {
            normal = "#6699cc";
            bright = "#85add6";
          };

          magenta = {
            normal = "#c695c6";
            bright = "#d8b6d8";
          };

          cyan = {
            normal = "#5fb4b4";
            bright = "#82c4c4";
          };

          white = {
            normal = "#f7f7f7";
            bright = "#ffffff";
          };
        };
      }
    ];
  };
}
