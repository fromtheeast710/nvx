{lib, ...}: let
  inherit (lib.nixvim) mkRaw;
in {
  plugins = {
    blink-cmp = {
      enable = true;
      settings = {
        sources = {
          default = [
            "lsp"
            "path"
            # "luasnip"
            "snippets"
            "buffer"
            "spell"
            "dictionary"
            "git"
          ];
          providers = {
            git = {
              module = "blink-cmp-git";
              name = "git";
              score_offset = 100;
              opts = {
                commit = {};
                git_centers = {git_hub = {};};
              };
            };
            spell = {
              module = "blink-cmp-spell";
              name = "Spell";
              score_offset = 100;
              opts = {};
            };
            dictionary = {
              module = "blink-cmp-dictionary";
              name = "Dict";
              score_offset = 100;
              min_keyword_length = 3;
              opts = {};
            };
            luasnip = {
              module = "luasnip";
              name = "Snippet";
              score_offset = 100;
              min_keyword_length = 3;
              opts = {};
            };
          };
        };
        keymap = {
          preset = "none";
          "<tab>" = ["select_next" "fallback"];
          "<s-tab>" = ["select_prev" "fallback"];
          "<cr>" = ["accept" "fallback"];
        };
      };
    };
    barbar = {
      enable = true;
      settings = {
        auto_hide = 1;
        pinned = {
          button = "󰐃";
          filename = true;
        };
      };
    };
    lualine = {
      enable = true;
      luaConfig.pre = builtins.readFile ./bar.lua;
    };
    hop = {
      enable = true;
      settings = {
        keys = "asdfghjkl;";
        dim_unmatched = true;
      };
    };
    treesitter-context = {
      enable = true;
      settings = {
        multiwindow = true;
        max_lines = 5;
        min_window_height = 3;
        multiline_threshold = 3;
        trim_scope = "outer";
      };
    };
    treesitter = {
      enable = true;
      settings.highlight.enable = true;
    };
    # BUG: not saving sessions
    auto-session = {
      enable = true;
      settings = {
        suppressed_dirs = ["/" "~/" "~/Downloads" "~/Games"];
        cwd_change_handling = mkRaw ''
          function()
            require "lualine".refresh()
          end
        '';
      };
    };
    gitsigns = {
      enable = true;
      settings = {
        sign_priority = 100;
        signs = {
          delete = {
            text = "│";
          };
          topdelete = {
            text = "│";
          };
          changedelete = {
            text = "│";
          };
        };
      };
    };
    sniprun = {
      enable = true;
      settings.display = [
        "VirtualTextOk"
        "LongTempFloatingWindow"
      ];
    };
    which-key = {
      enable = true;
      settings.preset = "helix";
    };
    blink-cmp-git.enable = true;
    blink-cmp-spell.enable = true;
    blink-cmp-dictionary.enable = true;
    illuminate.enable = true;
    luasnip.enable = true;
    typst-preview.enable = true;
    telescope.enable = true;
    otter.enable = true;
    floaterm.enable = true;
    origami.enable = true;
    todo-comments.enable = true;
    nvim-autopairs.enable = true;
    web-devicons.enable = true;
    direnv.enable = true;
    colorizer.enable = true;
  };
}
