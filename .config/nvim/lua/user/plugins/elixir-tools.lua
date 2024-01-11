return {
  "elixir-tools/elixir-tools.nvim",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local elixirls = require("elixir.elixirls")
    require("elixir").setup({
      nextls = { enable = false },
      credo = { enable = false },
      elixirls = {
        settings = elixirls.settings({
          dialyzerEnabled = false,
          enableTestLenses = false,
        }),
      },
    })

  end
}
