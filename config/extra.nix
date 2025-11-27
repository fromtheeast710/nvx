{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins;
    [
      nui-nvim
      mini-files
      bigfile-nvim
      nvim-comment
      vim-startuptime
      diagflow-nvim
      leetcode-nvim
      # image-nvim
    ]
    ++ (with pkgs.vimUtils; [
      (buildVimPlugin rec {
        pname = "spaceless.nvim";
        version = "unstable";
        src = pkgs.fetchFromGitHub {
          owner = "lewis6991";
          repo = pname;
          rev = "927fb0afb416ea39306af5842c247d810dfd5938";
          hash = "sha256-t9wZ6ZYS42BDkJ2wcphcgqLobThyiCfGwhBVTdX7iGQ=";
        };

        # TODO: inject lua config here
        # luaCfg = '''';
      })
      (buildVimPlugin rec {
        pname = "spin.nvim";
        version = "unstable";
        src = pkgs.fetchFromGitHub {
          owner = "sebostien";
          repo = pname;
          rev = "717e96e526cfb99a51b908b166f163e650566f38";
          hash = "sha256-gKKOof2GZqvc4Zs/S3gHnvlgz4swxmuoZU5tVE4+wDg=";
        };
      })
      (buildVimPlugin rec {
        pname = "idris2-nvim";
        version = "unstable";
        src = pkgs.fetchFromGitHub {
          owner = "idris-community";
          repo = pname;
          rev = "e3d4242a525ec8f1e0846f47b9730035a046100f";
          hash = "sha256-udQMonzOIAooaFvAqSzx3r7HEpytfhCbX6Y83iaiMwE=";
        };

        buildInputs = with pkgs;
          [
            # idris2
            idris2Packages.idris2Lsp
          ]
          ++ (with vimPlugins; [
            nui-nvim
            nvim-lspconfig
          ]);
      })
      (buildVimPlugin rec {
        pname = "vim-nickel";
        version = "unstable";
        src = pkgs.fetchFromGitHub {
          owner = "nickel-lang";
          repo = pname;
          rev = "f22898d88affc0958453b42e1147ba076637e0ed";
          hash = "sha256-wb8UNs0eF6939pjZWafDoFgRh/10rKorJFZtPbTkn/k=";
        };
      })
      (buildVimPlugin rec {
        pname = "actions-preview";
        version = "unstable";
        src = pkgs.fetchFromGitHub {
          owner = "aznhe21";
          repo = pname + ".nvim";
          rev = "36513ad213855d497b7dd3391a24d1d75d58e36f";
          hash = "sha256-rQjwlu5gQcOvxF72lr9ugPRl0W78wCWGWPhpN1oOMbs=";
        };

        buildInputs = with pkgs; [
          diff-so-fancy
        ];
      })
      # (buildVimPlugin rec {
      #   pname = "nvim-agda";
      #   version = "unstable";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "ashinkarov";
      #     repo = pname;
      #     rev = "9024909ac5cbac0a0b6f1f3f7f2b65c907c8fc12";
      #     hash = "";
      #   };
      # })
    ]);

  extraConfigLua = builtins.readFile ./extra.lua;
}
