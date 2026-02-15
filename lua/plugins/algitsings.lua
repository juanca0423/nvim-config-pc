return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup({
      signs = {
        add          = { text = '▎' },
        change       = { text = '▎' },
        delete       = { text = '' },
        topdelete    = { text = '' },
        changedelete = { text = '▎' },
        untracked    = { text = '┆' },
      },
      current_line_blame = true,
      current_line_blame_opts = { delay = 500 },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        -- Navegación rápida entre cambios
        vim.keymap.set('n', ']c', gs.next_hunk, { buffer = bufnr, desc = "Siguiente cambio" })
        vim.keymap.set('n', '[c', gs.prev_hunk, { buffer = bufnr, desc = "Cambio anterior" })
        -- Previsualizar el cambio en flotante
        vim.keymap.set('n', '<leader>gp', gs.preview_hunk, { buffer = bufnr, desc = "Preview Git" })
      end
    })
  end
}
