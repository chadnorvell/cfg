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
    fish-lsp
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
    procps
    ripgrep
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
