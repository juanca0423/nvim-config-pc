return {
  -- 1. Snippets (Fragmentos de código)
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    -- En Windows, 'make' suele fallar. Si te da error al instalar,
    -- puedes comentar la línea de 'build'.
    -- build = "make install_jsregexp"
    config = function()
      require("luasnip").setup({
        keep_roots = true,
        link_roots = true,
        link_children = true,
      })
    end
  },
  { "rafamadriz/friendly-snippets" },

  -- 2. Autopairs (Cierre automático de llaves/paréntesis)
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {} -- Esto es más limpio que 'config = true' en Lazy
  },

  -- 3. Iconos y Estética
  { 'onsails/lspkind.nvim' },
  {
    'nvim-tree/nvim-web-devicons',
    opts = { default = true } -- Corregido: Lazy prefiere usar opts o config
  },

  -- 4. Kulala (Cliente HTTP para Go/APIs)
  {
    'mistweaverco/kulala.nvim',
    ft = "http", -- Solo carga el plugin cuando abras archivos .http
    opts = {},
    keys = {
      { "<leader>hr", function() require('kulala').run() end,         desc = "Ejecutar petición HTTP" },
      { "<leader>ht", function() require('kulala').toggle_view() end, desc = "Cambiar vista Body/Headers" },
    },
  },
}
