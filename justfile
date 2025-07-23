# run nixvim
r *FILE:
  nix run . -- {{FILE}}
# check config
c:
  nix flake check .
# install new profile
i:
  nix profile remove nvx && nix profile add .
