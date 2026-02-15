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
    -- Fuerza la activación del motor en archivos Markdown
    vim.api.nvim_create_autocmd({ "FileType" }, {
      pattern = { "markdown" },
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
