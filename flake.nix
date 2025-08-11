{
  outputs = inputs:
    with inputs;
      flake-parts.lib.mkFlake {inherit inputs;} {
        systems = [
          "x86_64-linux"
          "aarch64-linux"
          "aarch64-darwin"
        ];

        imports = [inputs.treefmt.flakeModule];

        perSystem = {system, ...}: let
          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};
          nixvimModule = {
            inherit system;

            module = import ./config;

            extraSpecialArgs = {
              # inherit (foo) bar;
            };
          };
          nvim = nixvim'.makeNixvimWithModule nixvimModule;

          # TODO: integrate treefmt to nixvim
          treefmt.config = {
            projectRootFile = "flake.nix";

            programs = {
              alejandra.enable = true;
              ruff-format.enable = true;
            };
          };

          formatter = treefmt.build.wrapper;
        in {
          checks = {
            default =
              nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
            format = treefmt.build.check;
          };

          packages.default = nvim;
        };
      };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";
    treefmt.url = "github:numtide/treefmt-nix";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
}
