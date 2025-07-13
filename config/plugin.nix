{
  pkgs,
  lib,
  ...
}: let
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
      luaConfig.pre = ''
        local c = require('onedark.colors')
        local colors = {
          bg = c.bg0,
          fg = c.fg,
          red = c.red,
          green = c.green,
          yellow = c.yellow,
          blue = c.blue,
          purple = c.purple,
          cyan = c.cyan,
          gray = c.grey
        }

        local conditions = {
          buffer_not_empty = function()
            return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
          end,
          hide_in_width = function()
            return vim.fn.winwidth(0) > 80
          end,
          check_git_workspace = function()
            local filepath = vim.fn.expand('%:p:h')
            local gitdir = vim.fn.finddir('.git', filepath .. ';')
            return gitdir and #gitdir > 0 and #gitdir < #filepath
          end,
        }

        local config = {
          options = {
            component_separators = "",
            section_separators = "",
          },
          sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_y = {},
            lualine_z = {},
            lualine_c = {},
            lualine_x = {},
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_y = {},
            lualine_z = {},
            lualine_c = {},
            lualine_x = {},
          },
        }

        local function ins_left(component)
          table.insert(config.sections.lualine_c, component)
        end

        local function ins_right(component)
          table.insert(config.sections.lualine_x, component)
        end

        ins_left {
          function()
            return '█'
          end,
          color = function()
            local mode_color = {
              n = colors.red,
              i = colors.green,
              v = colors.blue,
              [''] = colors.blue,
              V = colors.blue,
              c = colors.magenta,
              no = colors.red,
              s = colors.orange,
              S = colors.orange,
              [''] = colors.orange,
              ic = colors.yellow,
              R = colors.violet,
              Rv = colors.violet,
              cv = colors.red,
              ce = colors.red,
              r = colors.cyan,
              rm = colors.cyan,
              ['r?'] = colors.cyan,
              ['!'] = colors.red,
              t = colors.red,
            }
            return { fg = mode_color[vim.fn.mode()] }
          end,
          padding = { right = 1 },
        }

        ins_left {
          'branch',
          icon = '',
          color = { fg = colors.violet, gui = 'bold' },
        }

        ins_left {
          'diff',
          symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
          diff_color = {
            added = { fg = colors.green },
            modified = { fg = colors.orange },
            removed = { fg = colors.red },
          },
          cond = conditions.hide_in_width,
        }

        ins_left {
          'diagnostics',
          sources = { 'nvim_diagnostic' },
          symbols = { error = ' ', warn = ' ', info = ' ' },
          diagnostics_color = {
            error = { fg = colors.red },
            warn = { fg = colors.yellow },
            info = { fg = colors.cyan },
          },
        }

        ins_left {
          function()
            return '%='
          end,
        }

        ins_left {
          function()
            local msg = 'No Active Lsp'
            local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
            local clients = vim.lsp.get_clients()
            if next(clients) == nil then
              return msg
            end
            for _, client in ipairs(clients) do
              local filetypes = client.config.filetypes
              if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
              end
            end
            return msg
          end,
          icon = ' ',
          color = { fg = '#ffffff', gui = 'bold' },
        }

        -- ins_right {
        --   'o:encoding',
        --   fmt = string.upper,
        --   cond = conditions.hide_in_width,
        --   color = { fg = colors.green, gui = 'bold' },
        -- }

        ins_right {
          'fileformat',
          fmt = string.upper,
          icons_enabled = true,
          color = { fg = colors.green, gui = 'bold' },
        }

        ins_right {
          'filesize',
          cond = conditions.buffer_not_empty,
        }

        ins_right { 'location' }

        ins_right { 'progress', color = { fg = colors.fg, gui = 'bold' } }

        require "lualine".setup(config)
      '';
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
        max_lines = 0;
        min_window_height = 3;
        multiline_threshold = 3;
        trim_scope = "outer";
      };
    };
    treesitter = {
      enable = true;
      settings.highlight.enable = true;
    };
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
    blink-cmp-git.enable = true;
    blink-cmp-spell.enable = true;
    blink-cmp-dictionary.enable = true;
    luasnip.enable = true;
    typst-preview.enable = true;
    telescope.enable = true;
    otter.enable = true;
    sniprun.enable = true;
    floaterm.enable = true;
    origami.enable = true;
    todo-comments.enable = true;
    nvim-autopairs.enable = true;
    web-devicons.enable = true;
    direnv.enable = true;
    which-key.enable = true;
    colorizer.enable = true;
  };
}
