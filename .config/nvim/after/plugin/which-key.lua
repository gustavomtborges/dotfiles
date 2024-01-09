local wk = require("which-key")
wk.setup({
  layout = {
    align = "center",
  },
})

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

-- Harpoon
wk.register({
  ["<leader>a"] = {
    mark.add_file,
    "Harpoon add file",
  },
  ["<leader>;"] = {
    ui.toggle_quick_menu,
    "Harpoon open menu",
  },
  ["<C-h>"] = {
    function()
      ui.nav_file(1)
    end,
    "Harpoon file 1",
  },
  ["<C-t>"] = {
    function()
      ui.nav_file(2)
    end,
    "Harpoon file 2",
  },
  ["<C-n>"] = {
    function()
      ui.nav_file(3)
    end,
    "Harpoon file 3",
  },
  ["<C-l>"] = {
    function()
      ui.nav_file(4)
    end,
    "Harpoon file 4",
  },
})

wk.register({
  ["<C-p>"] = {
    function()
      require("telescope.builtin").find_files({ previewer = false })
    end,
    "Find File",
  },
  ["<leader>e"] = {
    ":NvimTreeToggle<CR>",
    "Open explorer",
  },
  -- ["<leader>j"] = {
  -- 	":bprev<CR>",
  -- 	"Previous buffer",
  -- },
  -- ["<leader>k"] = {
  -- 	":bnext<CR>",
  -- 	"Next buffer",
  -- },
  -- ["<C-j>"] = {
  -- 	":BufferLineCyclePrev<CR>",
  -- 	"Previous buffer",
  -- },
  -- ["<leader>J"] = {
  -- 	":BufferLineMovePrev<CR>",
  -- 	"Move buffer left",
  -- },
  -- ["<C-k>"] = {
  -- 	":BufferLineCycleNext<CR>",
  -- 	"Next buffer",
  -- },
  -- ["<leader>K"] = {
  -- 	":BufferLineMoveNext<CR>",
  -- 	"Move buffer right",
  -- },
  ["<leader>o"] = {
    function()
      require("telescope.builtin").buffers({
        sort_mru = true,
        ignore_current_buffer = true,
        previewer = false,
      })
    end,
    "Opened buffers",
  },
  ["<leader>q"] = {
    ":bd<CR>",
    "Close buffer",
  },
  ["<leader>Q"] = {
    ":q<CR>",
    "Close window",
  },
  ["[g"] = {
    function()
      require("gitsigns").prev_hunk({ buffer = true })
    end,
    "Previous change",
  },
  ["[d"] = {
    function()
      vim.diagnostic.goto_prev()
    end,
    "Previous diagnostic",
  },
  ["]g"] = {
    function()
      require("gitsigns").next_hunk({ buffer = true })
    end,
    "Next change",
  },
  ["]d"] = {
    function()
      vim.diagnostic.goto_next()
    end,
    "Next diagnostic",
  },
  ["<leader>R"] = {
    "*``cgn",
    "Replace word forward",
  },
  ["<leader>f"] = {
    name = "+file",
  },
  ["<leader>fw"] = {
    function()
      require("telescope.builtin").live_grep()
    end,
    "Find word",
  },
  ["<leader>fm"] = {
    function()
      require("telescope.builtin").marks()
    end,
    "Find bookmarks",
  },
  ["<leader>fr"] = {
    function()
      require("telescope.builtin").oldfiles()
    end,
    "Find recent files",
  },
  ["<leader>ff"] = {
    function()
      require("telescope.builtin").find_files({ previewer = false, hidden = true })
    end,
    "Find files (.hidden)",
  },
  ["<leader>fc"] = {
    function()
      require("telescope.builtin").grep_string()
    end,
    "Find word under cursor",
  },
  ["<leader>c"] = { name = "+code [LSP]" },
  ["gd"] = {
    function()
      vim.lsp.buf.definition()
    end,
    "Go to definition",
  },
  ["gD"] = {
    function()
      vim.lsp.buf.declaration()
    end,
    "Go to declaration",
  },
  ["gr"] = {
    function()
      vim.lsp.buf.references()
    end,
    "Go to references",
  },
  ["<leader>ci"] = {
    function()
      require("telescope.builtin").lsp_implementations()
    end,
    "Go to implementation",
  },
  ["<leader>r"] = {
    function()
      vim.lsp.buf.rename()
    end,
    "Rename",
  },
  ["<leader>h"] = {
    function()
      vim.lsp.buf.hover()
    end,
    "Preview docs",
  },
  ["<leader>H"] = {
    function()
      vim.lsp.buf.signature_help()
    end,
    "Preview signature",
  },
  ["<leader>ca"] = {
    function()
      vim.lsp.buf.code_action()
    end,
    "Code actions",
  },
  ["<leader>cj"] = {
    function()
      require("telescope.builtin").lsp_document_symbols()
    end,
    "Jump to symbol",
  },
  ["<leader>cf"] = {
    function()
      vim.lsp.buf.format({ buffer = true, async = true })
    end,
    "Format buffer",
  },
  ["<leader>g"] = { name = "+git" },
  ["<leader>gs"] = {
    function()
      require("telescope.builtin").git_status()
    end,
    "List git changes",
  },
  ["<leader>gb"] = {
    function()
      require("telescope.builtin").git_branches()
    end,
    "List git branches",
  },
  ["<leader>gc"] = {
    function()
      require("telescope.builtin").git_commits()
    end,
    "List commits",
  },
  ["<leader>gh"] = {
    function()
      require("telescope.builtin").git_bcommits()
    end,
    "Show file history",
  },
  ["<leader>gx"] = {
    ":GitConflictListQf<CR>",
    "Comflict files",
  },
  ["<leader>ga"] = {
    ":Gitsigns stage_hunk<CR>",
    "Stage hunk",
  },
  ["<leader>gr"] = {
    ":Gitsigns reset_hunk<CR>",
    "Restore hunk",
  },
  ["<leader>gA"] = {
    function()
      require("gitsigns").stage_buffer()
    end,
    "Stage buffer",
  },
  ["<leader>gR"] = {
    function()
      require("gitsigns").reset_buffer()
    end,
    "Restore buffer",
  },
  ["<leader>gp"] = {
    function()
      require("gitsigns").preview_hunk()
    end,
    "Preview hunk",
  },
  ["<leader>gl"] = {
    function()
      require("gitsigns").toggle_current_line_blame()
    end,
    "Blame",
  },
  ["<leader>gd"] = {
    function()
      require("gitsigns").diffthis()
    end,
    "Diff",
  },
  ["<leader>gD"] = {
    function()
      require("gitsigns").diffthis("~")
    end,
    "Diff buffer",
  },
  ["<leader>s"] = {
    ":SymbolsOutline<CR>",
    "Symbols outline",
  },
  ["<leader>d"] = {
    ":TroubleToggle<CR>",
    "Diagnostic",
  },
  ["<leader>D"] = {
    ":TroubleToggle workspace_diagnostics<CR>",
    "Diagnostic Workspace",
  },
  ["<leader>t"] = {
    name = "+toggle",
  },
  ["<leader>th"] = {
    ":nohl<CR>",
    "Search highligh",
  },
  ["<leader>tw"] = {
    ":set wrap!<CR>",
    "Word wrap",
  },
  ["<leader>tc"] = {
    ":set list!<CR>",
    "Hidden chars",
  },
  ["<leader>ts"] = {
    ":set spell!<CR>",
    "Spell checking",
  },
  -- ["<leader>b"] = {
  -- 	name = "+buffers",
  -- },
  -- ["<leader>bk"] = {
  -- 	":bd<CR>",
  -- 	"Close buffer",
  -- },
  -- ["<leader>bn"] = {
  -- 	":BufferLineMoveNext<CR>",
  -- 	"Move Next",
  -- },
  -- ["<leader>bp"] = {
  -- 	":BufferLineMovePrev<CR>",
  -- 	"Move Previous",
  -- },
  ["<leader>z"] = {
    name = "+zettelkasten",
  },
  ["<leader>za"] = {
    function()
      require("telekasten").panel()
    end,
    "All options",
  },
  ["<leader>zf"] = {
    function()
      require("telekasten").find_notes()
    end,
    "Find notes",
  },
  ["<leader>zn"] = {
    function()
      require("telekasten").new_note()
    end,
    "New note",
  },
  ["<leader>zt"] = {
    function()
      require("telekasten").show_tags()
    end,
    "Find tags",
  },
  ["<leader>zi"] = {
    function()
      require("telekasten").insert_link()
    end,
    "Insert link",
  },
  ["<leader>zl"] = {
    function()
      require("telekasten").follow_link()
    end,
    "Follow link",
  },
  ["<leader>zr"] = {
    function()
      require("telekasten").rename_note()
    end,
    "Rename note",
  },
  ["<leader>zd"] = {
    function()
      require("telekasten").goto_today()
    end,
    "Go to today",
  },
  ["<leader>zw"] = {
    function()
      require("telekasten").goto_thisweek()
    end,
    "Go to this week",
  },
  ["<leader>zc"] = {
    function()
      require("telekasten").show_calendar()
    end,
    "Show calendar",
  },
  ["<leader>u"] = {
    "<cmd>Telescope undo<CR>",
  },
})

-- Git
wk.register({
  g = {
    name = "+git",
  },
  ["<leader>ga"] = {
    ":Gitsigns stage_hunk<CR>",
    "Stage hunk",
  },
  ["<leader>gr"] = {
    ":Gitsigns reset_hunk<CR>",
    "Reset hunk",
  },
}, { mode = "v" })
