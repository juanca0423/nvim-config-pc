return {
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      columns = { "icon" }, -- Muestra iconos a la izquierda
      keymaps = {
        ["<CR>"] = "actions.select",
        ["<C-h>"] = false, -- Evita conflictos con navegación de ventanas
        ["<C-l>"] = false,
        ["-"] = "actions.parent",
      },
      view_options = {
        show_hidden = true,
      },
    })
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Abrir Oil" })
  end
}
