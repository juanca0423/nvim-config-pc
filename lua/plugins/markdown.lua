return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  opts = {
    file_types = { 'markdown', 'codecompanion' }, -- Útil si luego instalas IA
    html = { enabled = false },
    latex = { enabled = false },
    yaml = { enabled = false },
    heading = {
      icons = { '◉ ', '○ ', '✸ ', '✿ ' }, -- Iconos personalizados para niveles de título
    },
  },
}
