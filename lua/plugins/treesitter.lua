return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    -- El pcall protege contra el error de "module not found" si algo falla
    local ok, configs = pcall(require, "nvim-treesitter.configs")
    if not ok then return end

    configs.setup({
      ensure_installed = { "go", "lua", "markdown", "markdown_inline", "html" },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    })
    -- Fuerza la activación del motor en archivos Markdown con un delay mínimo
    vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
      pattern = { "*.md", "markdown" },
      callback = function()
        -- Usamos pcall para evitar errores si el parser aún se está cargando
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
