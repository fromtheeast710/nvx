# run nixvim
r *FILE:
  nix run . -- {{FILE}}
# check config
c:
  nix flake check .
i:
  nix profile remove nvx && nix profile add .