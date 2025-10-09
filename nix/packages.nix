{
  pkgs,
  pkgs-unstable,
  ...
}:

let
  stable = with pkgs; [
    clang
    clang-tools
    curl
    delta
    eza
    fastfetch
    fd
    ffmpeg
    file
    fish-lsp
    flac
    fzf
    gcc
    groff
    gum
    hexyl
    htop
    imagemagick
    jq
    lua-language-server
    man-pages
    man-pages-posix
    nil
    nixfmt-rfc-style
    opusTools
    procps
    ripgrep
    rsgain
    rsync
    silver-searcher
    statix
    stylua
    trash-cli
    yq
  ];

  unstable = with pkgs-unstable; [
    graphite-cli
  ];
in
stable ++ unstable
