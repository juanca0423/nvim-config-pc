return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  event = "VeryLazy",
  opts = {
    options = {
      mode = "buffers",
      separator_style = "slant",
      show_buffer_close_icons = true,
      show_close_icon = false,
      diagnostics = "nvim_lsp",
      -- Esto es clave para que no choque con Alpha
      offsets = {
        {
          filetype = "NvimTree",
          text = "EXPLORADOR",
          text_align = "left",
          separator = true,
        },
      },
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)

    -- ATAJOS PARA TUS BUFFERS
    vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Siguiente Buffer" })
    vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Anterior Buffer" })
    vim.keymap.set("n", "<leader>q", "<cmd>bdelete<cr>", { desc = "Cerrar Buffer actual" })
    vim.keymap.set("n", "<leader>bc", "<cmd>BufferLinePickClose<cr>", { desc = "Elegir buffer para cerrar" })
  end,
}
