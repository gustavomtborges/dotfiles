local default_opts = { noremap = true, silent = true }
local function keymap(mode, lhs, rhs, opts)
  local options = {}
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

vim.g.mapleader = " "

keymap("i", "jk", "<esc>")

-- Save with Ctrl-s
keymap("n", "<C-s>", ":<c-u>update<CR>", default_opts)
keymap("v", "<C-s>", ":<c-c>update<CR>gv", default_opts)
keymap("i", "<C-s>", ":<c-o>update<CR>", default_opts)

-- Replace current word
keymap("n", "<leader>r", "*``cgn", default_opts)
keymap("n", "<leader>R", "#``cgN", default_opts)

-- Move esasly between splits
keymap("n", "<C-j>", "<C-w><C-j>", default_opts)
keymap("n", "<C-k>", "<C-w><C-k>", default_opts)
keymap("n", "<C-l>", "<C-w><C-l>", default_opts)
keymap("n", "<C-h>", "<C-w><C-h>", default_opts)

-- Copy to clipboard
keymap("v", "Y", '"+y', default_opts)

local wk = require("which-key")
wk.setup({
  layout = {
    align = "center",
  },
})

wk.register({
  p = {
    function()
      require("telescope.builtin").find_files({ previewer = false })
    end,
    "Find File",
  },
  q = {
    ":Bdelete<CR>",
    "Close buffer",
  },
  j = {
    ":BufferLineCyclePrev<CR>",
    "Previous buffer",
  },
  k = {
    ":BufferLineCycleNext<CR>",
    "Next buffer",
  },
  [";"] = {
    function()
      require("telescope.builtin").buffers({
        sort_mru = true,
        ignore_current_buffer = true,
        previewer = false,
      })
    end,
    "Opened buffers",
  },
  u = {
    function()
      vim.diagnostic.goto_prev()
    end,
    "Previous diagnostic",
  },
  i = {
    function()
      vim.diagnostic.goto_next()
    end,
    "Next diagnostic",
  },
  e = {
    function()
      require("gitsigns").prev_hunk({ buffer = true })
    end,
    "Previous git change",
  },
  r = {
    function()
      require("gitsigns").next_hunk({ buffer = true })
    end,
    "Next git change",
  },
  f = {
    name = "+file",
    w = {
      function()
        require("telescope.builtin").live_grep()
      end,
      "Find word",
    },
    m = {
      function()
        require("telescope.builtin").marks()
      end,
      "Find bookmarks",
    },
    r = {
      function()
        require("telescope.builtin").oldfiles()
      end,
      "Find recent files",
    },
    f = {
      function()
        require("telescope.builtin").find_files({ previewer = false, hidden = true, no_ignore = true })
      end,
      "Find files (.gitignore)",
    },
  },
  c = {
    name = "+code [LSP]",
    d = {
      function()
        require("telescope.builtin").lsp_definitions()
      end,
      "Go to definition",
    },
    D = {
      function()
        require("telescope.builtin").lsp_references()
      end,
      "Go to references",
    },
    i = {
      function()
        require("telescope.builtin").lsp_implementations()
      end,
      "Go to implementation",
    },
    r = {
      function()
        vim.lsp.buf.rename()
      end,
      "Rename",
    },
    k = {
      function()
        vim.lsp.buf.hover()
      end,
      "Preview docs",
    },
    h = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "Preview signature",
    },
    a = {
      "<cmd>Lspsaga code_action<CR>",
      "Code actions",
    },
    j = {
      function()
        require("telescope.builtin").lsp_document_symbols()
      end,
      "Jump to symbol",
    },
    f = {
      function()
        vim.lsp.buf.format({ buffer = true, async = true })
      end,
      "Format buffer",
    },
  },
  g = {
    name = "+git",
    s = {
      function()
        require("telescope.builtin").git_status()
      end,
      "List git changes",
    },
    b = {
      function()
        require("telescope.builtin").git_branches()
      end,
      "List git branches",
    },
    c = {
      function()
        require("telescope.builtin").git_commits()
      end,
      "List commits",
    },
    h = {
      function()
        require("telescope.builtin").git_bcommits()
      end,
      "Show file history",
    },
    x = {
      ":GitConflictListQf<CR>",
      "Comflict files",
    },
    a = {
      ":Gitsigns stage_hunk<CR>",
      "Stage hunk",
    },
    r = {
      ":Gitsigns reset_hunk<CR>",
      "Restore hunk",
    },
    A = {
      function()
        require("gitsigns").stage_buffer()
      end,
      "Stage buffer",
    },
    R = {
      function()
        require("gitsigns").reset_buffer()
      end,
      "Restore buffer",
    },
    p = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview hunk",
    },
    l = {
      function()
        require("gitsigns").toggle_current_line_blame()
      end,
      "Blame",
    },
    d = {
      function()
        require("gitsigns").diffthis()
      end,
      "Diff",
    },
    D = {
      function()
        require("gitsigns").diffthis("~")
      end,
      "Diff buffer",
    },
  },
  o = {
    name = "+open",
    e = {
      ":NvimTreeToggle<CR>",
      "Project explorer",
    },
    s = {
      ":SymbolsOutline<CR>",
      "Symbols outline",
    },
    d = {
      name = "Diagnostic",
      d = {
        ":TroubleToggle<CR>",
        "Diagnostic",
      },
      w = {
        ":TroubleToggle workspace_diagnostics<CR>",
        "Diagnostic Workspace",
      },
    },
    c = {
      ":edit ~/.config/nvim/lua <CR>",
      "Config",
    },
    q = {
      ":copen<CR>",
      "Quickfix",
    },
    m = {
      ":MarkdownPreview<CR>",
      "Markdown Preview",
    },
  },
  t = {
    name = "+toggle",
    h = {
      ":nohl<CR>",
      "Search highligh",
    },
    w = {
      ":set wrap!<CR>",
      "Word wrap",
    },
    c = {
      ":set list!<CR>",
      "Hidden chars",
    },
    s = {
      ":set spell!<CR>",
      "Spell checking",
    },
    m = {
      ":MarkdownPreview<CR>",
      "Markdown Preview",
    },
  },
  b = {
    name = "+buffers",
    k = {
      ":Bdelete<CR>",
      "Close buffer",
    },
    K = {
      ":%Bdelete<CR>",
      "Close all buffers",
    },
    l = {
      function()
        require("telescope.builtin").buffers({
          sort_mru = true,
          ignore_current_buffer = true,
        })
      end,
      "Opened buffers",
    },
    [">"] = {
      ":BufferLineMoveNext<CR>",
      "Move Next",
    },
    ["<"] = {
      ":BufferLineMovePrev<CR>",
      "Move Previous",
    },
  },
  z = {
    name = "+zettelkasten",
    a = {
      function()
        require("telekasten").panel()
      end,
      "All options",
    },
    f = {
      function()
        require("telekasten").find_notes()
      end,
      "Find notes",
    },
    s = {
      function()
        require("telekasten").search_notes()
      end,
      "Search in notes",
    },
    n = {
      function()
        require("telekasten").new_note()
      end,
      "New note",
    },
    t = {
      function()
        require("telekasten").show_tags()
      end,
      "Find tags",
    },
    i = {
      function()
        require("telekasten").insert_link()
      end,
      "Insert link",
    },
    l = {
      function()
        require("telekasten").follow_link()
      end,
      "Follow link",
    },
    r = {
      function()
        require("telekasten").rename_note()
      end,
      "Rename note",
    },
  },
}, { prefix = "<leader>" })

wk.register({
  g = {
    name = "+git",
    a = {
      ":Gitsigns stage_hunk<CR>",
      "Stage hunk",
    },
    r = {
      ":Gitsigns reset_hunk<CR>",
      "Reset hunk",
    },
  },
}, { mode = "v", prefix = "<leader>" })
