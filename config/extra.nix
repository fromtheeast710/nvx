{
  pkgs,
  ...
}: {
  extraPlugins = with pkgs.vimPlugins; [
    # vim-agda
    mini-files
    bigfile-nvim
    nvim-comment
    vim-startuptime
    diagflow-nvim
  ];

  extraConfigLua = ''
    require "which-key".add {
      { "jk", "<esc>", desc = "Escape", mode = "i" },
      {
        { "<A-k>", "<cmd>wincmd k<cr>", desc = "Window Up" },
        { "<A-j>", "<cmd>wincmd j<cr>", desc = "Window Down" },
        { "<A-h>", "<cmd>wincmd h<cr>", desc = "Window Left" },
        { "<A-l>", "<cmd>wincmd l<cr>", desc = "Window Right" },
      },
      {
        mode = { "n" },
        { "<C-j>",    "<cmd>BufferNext<cr>",               desc = "Next Buffer" },
        { "<C-k>",    "<cmd>BufferPrevious<cr>",           desc = "Prev Buffer" },
        { "<space>i", "<cmd>lua vim.lsp.buf.format()<cr>", desc = "Indent" },
        { "<space>/", "<cmd>CommentToggle<cr>",            desc = "Comment" },
        { "<space>o", "<cmd>lua MiniFiles.open()<cr>",     desc = "Open File" },
        { "<space>f", "<cmd>Telescope find_files<cr>",     desc = "Find File" },
        { "<space>t", "<cmd>FloatermNew<cr>",              desc = "Float Term" },
        { "<space>h", "<cmd>noh<cr>",                      desc = "No Hilight" },
        { "<space>c", "<cmd>BufferClose<cr>",              desc = "Close Buffer" },
        { "<space>a", "<cmd>HopChar2<cr>",                 desc = "Jump" },
        { "<space>q", ":wqa!<cr>",                         desc = "Quit" },
      },
      {
        mode = { "x" },
        { "<space>/", ":'<,'>CommentToggle<cr>", desc = "Comment" },
      },
      {
        { "<space>b",  group = "Buffer" },
        { "<space>bp", "<cmd>BufferPick<cr>", desc = "Pick" },
        { "<space>bP", "<cmd>BufferPin<cr>",  desc = "Pin" },
      },
      {
        { "<space>S",  group = "Session" },
        { "<space>Ss", "<cmd>SessionSave<cr>",          desc = "Save" },
        { "<space>Sp", "<cmd>SessionPurgeOrphaned<cr>", desc = "Purge" },
        { "<space>Sd", "<cmd>SessionDelete<cr>",        desc = "Delete" },
        { "<space>Sf", "<cmd>SessionSearch<cr>",        desc = "Search" },
        { "<space>Sr", "<cmd>SessionRestore<cr>",       desc = "Restore" },
      },
      {
        { "<space>T",  group = "Telescope" },
        { "<space>Ts", "<cmd>Telescope git_status<cr>",                desc = "Status" },
        { "<space>Th", "<cmd>Telescope command_history<cr>",           desc = "History" },
        { "<space>Tc", "<cmd>Telescope commands<cr>",                  desc = "Commands" },
        { "<space>Tp", "<cmd>Telescope help_tags<cr>",                 desc = "Help Tags" },
        { "<space>Tl", "<cmd>Telescope live_grep<cr>",                 desc = "Live Grep" },
        { "<space>Tf", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy Find" },
        { "<space>Ts", "<cmd>Telescope treesitter<cr>",                desc = "Treesitter" },
        { "<space>Td", "<cmd>Telescope diagnostics<cr>",               desc = "Diagnostics" },
        { "<space>Ta", "<cmd>Telescope autocommands<cr>",              desc = "Autocommands" },
      },
    }

    require "mini.files".setup {
      windows = {
        preview = true,
      },
    }

    require "bigfile".setup { filesize = 0.5 }

    require('diagflow').setup {
      show_borders = false,
      placement = 'inline',
      inline_padding_left = 3,
      format = function(diagnostic)
        return "▣ " .. diagnostic.message
      end
    }

    -- TODO: use otter for correct comment in embedded code block
    require 'nvim_comment'.setup {}

    -- TODO: use treefmt to format
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function()
        if #vim.lsp.get_clients({ bufnr = 0 }) > 0 then
          vim.lsp.buf.format()
        end
      end
    })

    for type, icon in pairs {
      Error = "",
      Warn  = "",
      Hint  = "",
      Info  = "",
    } do
      vim.fn.sign_define(
        "DiagnosticSign" .. type, { text = icon, texthl = "DiagnosticSign" .. type }
      )
    end
  '';
}
