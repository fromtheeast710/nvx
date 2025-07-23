{ 
  # inputs,
  pkgs,
  ...
}: {
  enableMan = false;

  extraPackages = with pkgs; [
    wordnet
    luajitPackages.luautf8
  ];

  imports = [
    ./lsp.nix
    ./extra.nix
    ./plugin.nix
    ./option.nix
    ./performance.nix
  ];
}
