return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      hijack_netrw = true,
      hijack_unnamed_buffer_when_opening = false, -- ¡ESTA ES CLAVE!
      -- 1. ESTO EVITA QUE SE ABRA EN C:\
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true, -- Cambia la raíz si abres un archivo de otro proyecto
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
          "NTUSER.*", -- Oculta los archivos de sistema de Windows
          "ntuser.*",
          "desktop.ini",
          "%.lnk",
        },
      },
    })
    vim.keymap.set("n", "<C-t>", ":NvimTreeToggle<CR>", { silent = true })
  end,
}
