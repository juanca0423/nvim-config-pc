return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<c-\>]], -- Ctrl + \ para abrir terminal general
      direction = "float",      -- Terminal flotante para que no te achique la pantalla
      float_opts = { border = "curved" },
    })

    -- Atajo para LazyDocker (Si lo tienes instalado en Windows)
    local Terminal = require('toggleterm.terminal').Terminal
    local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true, direction = "float" })

    vim.keymap.set("n", "<leader>dk", function() lazydocker:toggle() end, { desc = "LazyDocker" })
  end
}
