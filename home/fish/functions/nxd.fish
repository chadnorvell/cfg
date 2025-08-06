function nxd --wraps='nix develop --command fish'
  nix develop --command fish $argv
end
