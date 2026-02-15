return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Trouble",
  opts = {
    auto_close = true,
    restore_window_config = false,
    padding = false,
    -- Estilo más moderno para las señales de error
    icons = {
      indent = {
        top = "│ ",
        middle = "├ ",
        last = "└ ",
        fold_open = " ",
        fold_closed = " ",
        ws = "  ",
      },
    },
  },
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Proyecto: Errores" },
    { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer: Errores" },
    { "<leader>xq", "<cmd>Trouble quickfix toggle<cr>",                 desc = "Quickfix List" },
  },
}
