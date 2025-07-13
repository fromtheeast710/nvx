{ ... }: {
  enableMan = false;

  imports = [
    ./option.nix
    ./lsp.nix
    ./plugin.nix
    ./extra.nix
  ];
}
