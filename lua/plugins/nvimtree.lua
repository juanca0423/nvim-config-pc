return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- 1. Definimos la función de atajos (on_attach)
    local function my_on_attach(bufnr)
      local api = require("nvim-tree.api")

      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- Mapeos por defecto (esto activa a, d, r, etc.)
      api.config.mappings.default_on_attach(bufnr)

      -- Mapeos personalizados o reforzados
      vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
      vim.keymap.set("n", "h", api.node.open.horizontal, opts("Open: Horizontal Split"))
      vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
      vim.keymap.set("n", "a", api.fs.create, opts("Create"))
      vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
      vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
      vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Hidden"))
      vim.keymap.set("n", "q", api.tree.close, opts("Close"))
    end

    -- 2. Pasamos la función al setup
    require("nvim-tree").setup({
      on_attach = my_on_attach, -- ¡ESTO ACTIVA TUS TECLAS!
      hijack_netrw = true,
      hijack_unnamed_buffer_when_opening = false,
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      view = {
        width = 30,
        side = "left",
      },
      renderer = {
        indent_markers = { enable = true },
        icons = {
          glyphs = {
            default = "󰈚",
            symlink = "",
            folder = {
              arrow_open = "",
              arrow_closed = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
          },
        },
      },
      filters = {
        dotfiles = false,
        custom = {
          "node_modules",
          ".git",
          "%.cache",
          "NTUSER.*",
          "ntuser.*",
          "desktop.ini",
          "%.lnk",
        },
      },
    })

    vim.keymap.set("n", "<C-t>", ":NvimTreeToggle<CR>", { silent = true })
  end,
}
