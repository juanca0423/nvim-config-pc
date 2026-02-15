return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- Carga esto primero para evitar el flash blanco
  lazy = false,    -- Vital para que el tema cargue al abrir
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- Te sugiero 'mocha' para PC, 'latte' es el modo claro (blanco)
      term_colors = true,
      integrations = {
        bufferline = true,
        nvimtree = true,
        treesitter = true,
        telescope = { enabled = true },
        native_lsp = { enabled = true },
      }
    })

    -- 1. Aplicamos el tema base
    vim.cmd.colorscheme "catppuccin"

    -- 2. TUS PERSONALIZACIONES (Ahora sí funcionan)
    -- Resaltar el número de línea actual (Naranja claro)
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FAB387", bold = true })

    -- Números de línea normales (Amarillo suave)
    vim.api.nvim_set_hl(0, "LineNr", { fg = "#F9E2AF" })

    -- Columna de pliegues (Azul)
    vim.api.nvim_set_hl(0, "FoldColumn", { fg = "#89B4FA", bold = true })

    -- SignColumn (Donde salen los iconos de error)
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
  end,
}
