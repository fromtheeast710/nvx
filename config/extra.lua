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
    { "<C-j>",    "<cmd>BufferPrevious<cr>",                                desc = "Prev Buffer" },
    { "<C-k>",    "<cmd>BufferNext<cr>",                                    desc = "Next Buffer" },
    -- { "<space>i", "<cmd>lua vim.lsp.buf.format()<cr>", desc = "Indent" },
    { "<space>/", "<cmd>CommentToggle<cr>",                                 desc = "Comment" },
    { "<space>d", "<cmd>lua require('actions-preview').code_actions()<cr>", desc = "Comment" },
    { "<space>o", "<cmd>lua MiniFiles.open()<cr>",                          desc = "Open File" },
    { "<space>f", "<cmd>Telescope find_files<cr>",                          desc = "Find File" },
    { "<space>t", "<cmd>FloatermNew<cr>",                                   desc = "Float Term" },
    { "<space>h", "<cmd>noh<cr>",                                           desc = "No Hilight" },
    { "<space>c", "<cmd>BufferClose<cr>",                                   desc = "Close Buffer" },
    { "<space>a", "<cmd>HopChar2<cr>",                                      desc = "Jump" },
    { "<space>q", "<cmd>AutoSession save<CR><cmd>wqa!<CR>",                 desc = "Quit" },
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
  show_borders = true,
  padding_right = 3,
  max_width = 50,
  max_height = 100,
  placement = 'top',
  -- format = function(diagnostic)
  --   return diagnostic.message:gsub(" ", "_")
  -- end
}

require("actions-preview").setup {
  telescope = {
    sorting_strategy = "ascending",
    layout_strategy = "vertical",
    layout_config = {
      width = 0.8,
      height = 0.9,
      prompt_position = "top",
      preview_cutoff = 20,
      preview_height = function(_, _, max_lines)
        return max_lines - 15
      end,
    },
  },
}

require "leetcode".setup {
  lang = "python3",
  description = {
    position = "right",
  },
}

-- TODO: use otter for correct comment in embedded code block
require "nvim_comment".setup {}
require "spaceless".setup {}
-- require 'nickel'.setup {}

-- require "image".setup {
--   integrations = {
--     markdown = {
--       resolve_image_path = function(document_path, image_path, fallback)
--         return fallback(document_path, image_path)
--       end,
--     }
--   }
-- }

require 'spin'.setup {
  check_on_save = false,
}

require 'idris2'.setup {
  client = {
    hover = {
      use_split = false,
      split_size = '30%',
      auto_resize_split = true,
      split_position = 'right',
      with_history = true,
      use_as_popup = false,
    },
  },
}

-- TODO: use treefmt to format
local autocmd = vim.api.nvim_create_autocmd

autocmd("BufEnter", {
  pattern = "*.idr",
  callback = function()
    local act = "<cmd>lua require(\"idris2.code_action\")"
    local var = "<cmd>lua require(\"idris2.metavars\")"

    require "which-key".add {
      { "<space>i",  group = "Idris" },
      { "<space>if", var .. ".request_all()<cr>",       desc = "Find All Holes" },
      { "<space>is", act .. ".case_split()<cr>",        desc = "Split Case" },
      { "<space>im", act .. ".make_case()<cr>",         desc = "Make Case" },
      { "<space>iw", act .. ".make_with()<cr>",         desc = "Make With" },
      { "<space>il", act .. ".make_lemma()<cr>",        desc = "Make Lemma" },
      { "<space>ic", act .. ".add_clause()<cr>",        desc = "Add Clause" },
      { "<space>ir", act .. ".refine_hole()<cr>",       desc = "Refine Hole" },
      { "<space>ir", act .. ".expr_search_hints()<cr>", desc = "Refine Hole" },
      { "<space>ii", act .. ".intro()<cr>",             desc = "Fill Hole" },
    }
  end,
})

autocmd("BufWritePre", {
  callback = function()
    local excluded = {
      ".*%.idr", ".*%.typ", ".*%.vhd", "justfile",
    }

    local nix_fmt_files = {
      ".*%.nix",
    }

    local filename = vim.api.nvim_buf_get_name(0)

    for _, pattern in ipairs(excluded) do
      if filename:match(pattern) then
        return
      end
    end

    -- HACK: not using nix fmt
    for _, pattern in ipairs(nix_fmt_files) do
      if filename:match(pattern) then
        vim.cmd("silent! write")
        vim.fn.system({ "alejandra", filename })
        vim.cmd("edit!")

        return
      end
    end

    if #vim.lsp.get_clients({ bufnr = 0 }) > 0 then
      vim.lsp.buf.format()
    end
  end
})

autocmd({ "FileType", "BufRead", "BufNewFile" }, {
  pattern = { "markdown", "typst", "*" },
  callback = function()
    if vim.bo.buftype ~= "" then
      return
    end

    vim.opt_local.spell = true
    vim.cmd("syntax spell toplevel")
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
