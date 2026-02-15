return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    search = { multi_window = true },
    modes = {
      search = { enabled = true }, -- Integra Flash con la búsqueda nativa /
    },
    labels = "asdfghjklqwertyuiopzxcvbnm",
  },
  keys = {
    -- Cambiamos 'n' por 's' para no romper la búsqueda nativa
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash Jump" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o",               function() require("flash").remote() end,     desc = "Remote Flash" },
  },
}
