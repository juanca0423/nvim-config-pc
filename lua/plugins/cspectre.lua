return {
  "nvim-pack/nvim-spectre",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("spectre").setup({
      is_insert_mode = true,
      live_update    = true, -- Mira los cambios en tiempo real
      line_sep_start = '┌-----------------------------------------',
      result_padding = '¦  ',
      line_sep       = '└-----------------------------------------',
    })

    vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
      desc = "Spectre: Buscar y Reemplazar"
    })
  end,
}
