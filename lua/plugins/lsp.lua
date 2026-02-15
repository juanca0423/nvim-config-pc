return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    -- Corrección de PATH para Windows (VITAL)
    local separator = ";"
    local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
    vim.env.PATH = mason_bin .. separator .. vim.env.PATH

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "gopls", "lua_ls", "ts_ls", "html", "sqls" }
    })

    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local servers = { "lua_ls", "gopls", "ts_ls", "html", "cssls", "sqls" }

    for _, server in ipairs(servers) do
      local opts = { capabilities = capabilities }

      -- Ajustes específicos por lenguaje
      if server == "gopls" then
        opts.settings = { gopls = { completeUnimported = true, gofumpt = true } }
      elseif server == "lua_ls" then
        opts.settings = { Lua = { diagnostics = { globals = { 'vim' } } } }
      end

      -- Configuración nativa v0.11
      -- Si falla vim.lsp.config, usamos el fallback de lspconfig
      local ok, _ = pcall(function()
        vim.lsp.config(server, opts)
        vim.lsp.enable(server)
      end)

      if not ok then
        require('lspconfig')[server].setup(opts)
      end
    end

    -- Auto-comando para Organizar Imports en Go (v0.11 style)
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function()
        vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
}
