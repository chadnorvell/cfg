function drb --wraps='sudo darwin-rebuild switch --flake ~/dev/nix/darwin'
  sudo darwin-rebuild switch --flake ~/dev/nix/darwin $argv
end
