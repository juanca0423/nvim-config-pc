return {
  "gbprod/yanky.nvim",
  event = "BufReadPost", -- Carga solo al leer un archivo
  config = function()
    require("yanky").setup({
      ring = {
        storage = "shada", -- Usa el historial de Neovim para que persista al cerrar
      },
      system_clipboard = {
        sync_with_ring = true,
      }
    })
    -- Atajos
    vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
    vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
    -- CAMBIAMOS los atajos de ciclar para no chocar con NvimTree
    vim.keymap.set("n", "<M-p>", "<Plug>(YankyCycleForward)")  -- Alt + p
    vim.keymap.set("n", "<M-n>", "<Plug>(YankyCycleBackward)") -- Alt + n
  end
}
