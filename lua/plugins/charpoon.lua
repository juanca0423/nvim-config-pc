return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    -- Atajos de gestión
    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
      print("📌 Archivo marcado") -- Feedback visual rápido
    end, { desc = "Marcar archivo" })

    vim.keymap.set("n", "<C-e>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Menú Harpoon" })

    -- Saltos directos (1 al 5 son los más usados)
    -- Ajustado el bucle para que empiece en 1
    for i = 1, 5 do
      vim.keymap.set("n", "<A-" .. i .. ">", function()
        harpoon:list():select(i)
      end, { desc = "Harpoon " .. i })
    end
  end,
}
