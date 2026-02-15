return {
  'goolord/alpha-nvim',
  lazy = false,    -- Importante: Carga inmediata
  priority = 1000, -- Que cargue antes que casi todo lo demás
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local dashboard = require('alpha.themes.dashboard')

    -- HEADER: Logo GOJS
    dashboard.section.header.val = {
      [[                                  ]],
      [[    ██████╗  ██████╗      ██╗███████╗]],
      [[   ██╔════╝ ██╔═══██╗     ██║██╔════╝]],
      [[   ██║  ███╗██║   ██║     ██║███████╗]],
      [[   ██║   ██║██║   ██║██   ██║╚════██║]],
      [[   ╚██████╔╝╚██████╔╝╚█████╔╝███████║]],
      [[    ╚═════╝  ╚═════╝  ╚════╝ ╚══════╝]],
      [[                                  ]],
      [[      DEVELOPER: JUAN CARLOS      ]],
      [[    GO LANG • JAVASCRIPT STACK    ]],
      [[                                  ]],
    }

    -- BOTONES
    dashboard.section.buttons.val = {
      dashboard.button("f", "󰱼  BUSCAR ARCHIVO", ":Telescope find_files<CR>"),
      dashboard.button("r", "󱋡  ARCHIVOS RECIENTES", ":Telescope oldfiles<CR>"),
      dashboard.button("s", "󰺮  BUSCAR TEXTO", ":Telescope live_grep<CR>"),
      dashboard.button("e", "󰙅  EXPLORAR PROYECTO", ":NvimTreeToggle<CR>"),
      dashboard.button("c", "  AJUSTES NEOVIM", ":edit $MYVIMRC<CR>"),
      dashboard.button("q", "󰈆  SALIR DE EDITOR", ":qa<CR>"),
    }
    -- 1. Configuramos las opciones
    dashboard.opts.opts.noautocmd = true
    dashboard.opts.opts.window_config = { relative = "editor", row = 0, col = 0 }
    -- 2. Cargamos Alpha
    require('alpha').setup(dashboard.opts)

    -- 3. EL ELIMINADOR DE ERRORES (Añade esto justo debajo del setup)
    -- Esto busca cualquier autocomando de Alpha que cause el error de WinResized y lo borra
    vim.api.nvim_create_autocmd("VimEnter", {
      once = true,
      callback = function()
        -- Borramos los autocomandos que Alpha crea por defecto y que fallan en Windows
        pcall(vim.api.nvim_del_augroup_by_name, "alpha_temp")
        pcall(vim.api.nvim_del_augroup_by_name, "alpha_settings")
      end,
    })
    -- Dentro de tu dashboard.opts.opts o antes del setup
    dashboard.opts.opts.noautocmd = true

    -- Añade esto para que Alpha sepa que él es el buffer principal
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "alpha",
      callback = function()
        vim.opt_local.buflisted = true
        vim.opt_local.bufhidden = "hide"
      end
    })

    -- 4. Atajo manual protegido
    vim.keymap.set("n", "<leader>aa", function()
      pcall(vim.cmd, "Alpha")
    end, { desc = "Dashboard" })
    -- Esto hace que Alpha se comporte como un "muro" que no deja pasar buffers vacíos
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "alpha",
      callback = function()
        vim.opt_local.buflisted = false  -- No aparece en la lista de buffers
        vim.opt_local.bufhidden = "wipe" -- Se destruye totalmente al salir
        vim.opt_local.buftype = "nofile" -- Neovim sabe que no es un archivo
      end,
    })
  end
}
