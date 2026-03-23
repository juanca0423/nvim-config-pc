return {
  'hrsh7th/nvim-cmp',
  event = "InsertEnter",
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'onsails/lspkind.nvim',
    'rafamadriz/friendly-snippets',
  },
  config = function()
    local cmp = require('cmp')
    local lspkind = require('lspkind')
    local luasnip = require('luasnip')

    require('luasnip.loaders.from_vscode').lazy_load()

    -- 1. Configuración General (Go, JS, etc.)
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
      }),
      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = lspkind.cmp_format({
          mode = 'symbol_text',
          maxwidth = 50,
          menu = {
            nvim_lsp = "[LSP]",
            luasnip  = "[Snip]",
            buffer   = "[Buf]",
            path     = "[Path]",
          }
        }),
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp', priority = 1000 },
        { name = 'luasnip',  priority = 750 },
        { name = 'buffer',   keyword_length = 3 },
        { name = 'path' },
      }),
    })

    -- 2. CONFIGURACIÓN ESPECIAL PARA SQL (Aquí es donde lo agregamos)
    cmp.setup.filetype({ 'sql', 'mysql', 'plsql' }, {
      sources = cmp.config.sources({
        { name = 'vim-dadbod-completion' }, -- Sugerencias de tablas y columnas
        { name = 'buffer' },                -- Palabras que ya escribiste
      })
    })
  end,
}
