return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    require('neogen').setup({
      enabled = true,
      languages = {
        javascript = { template = { annotation_convention = "jsdoc" } },
        typescript = { template = { annotation_convention = "tsdoc" } },
        go = { template = { annotation_convention = "godoc" } },
      }
    })

    -- Atajos de teclado
    local opts = { silent = true, noremap = true }
    vim.keymap.set("n", "<leader>nf", function() require('neogen').generate({ type = 'func' }) end,
      { desc = "Doc Función" })
    vim.keymap.set("n", "<leader>nc", function() require('neogen').generate({ type = 'class' }) end,
      { desc = "Doc Struct" })
    vim.keymap.set("n", "<leader>np", function() require('neogen').generate({ type = 'file' }) end,
      { desc = "Doc Paquete" })
  end
}
