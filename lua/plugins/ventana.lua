-- ~/.config/nvim/lua/plugins/vim-test.lua
return {
  "vim-test/vim-test",
  dependencies = { "akinsho/toggleterm.nvim" },
  config = function()
    require("toggleterm").setup({
      size = 12,
      direction = "float",
      open_mapping = [[<c-\>]], -- Permite abrir/cerrar la terminal con Ctrl+\
    })
    vim.g["test#strategy"] = "toggleterm"
    -- Si no tienes gotestsum, cámbialo a 'go'
    vim.g["test#go#runner"] = "go"
  end,
  keys = {
    { "<leader>tn", "<cmd>TestNearest<CR>", desc = "Test Cercano" },
    { "<leader>tf", "<cmd>TestFile<CR>",    desc = "Test Archivo" },
    { "<leader>ts", "<cmd>TestSuite<CR>",   desc = "Test Suite Completa" },
  },
}
