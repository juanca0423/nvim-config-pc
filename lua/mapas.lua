-- =============================================================================
-- CONFIGURACIÓN PREVIA
-- =============================================================================
local ok_tree, nt_api = pcall(require, "nvim-tree.api")
local builtin = require('telescope.builtin')
local ls = require("luasnip")
local dap = require('dap')

-- =============================================================================
-- KEYMAPS GENERALES (Archivos y Ventanas)
-- =============================================================================
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = "Guardar" })
vim.keymap.set('n', '<leader>W', ':wq<CR>', { desc = "Guardar y Salir" })


vim.keymap.set('n', '<leader>ba', ':%bd|e#|bd#<CR>', { desc = "Cerrar los demás buffers" })

-- Moverse entre ventanas (Ctrl + Flechas) - Muy útil en Windows
vim.keymap.set('n', '<C-Left>', '<C-w>h', { desc = "Ventana Izquierda" })
vim.keymap.set('n', '<C-Down>', '<C-w>j', { desc = "Ventana Abajo" })
vim.keymap.set('n', '<C-Up>', '<C-w>k', { desc = "Ventana Arriba" })
vim.keymap.set('n', '<C-Right>', '<C-w>l', { desc = "Ventana Derecha" })

-- La función definitiva para cerrar archivos en Windows
vim.keymap.set("n", "<leader>q", function()
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })

  if #bufs <= 1 then
    -- Si es el último archivo, NO lo borres todavía.
    -- Primero traemos Alpha al frente.
    local ok, alpha = pcall(require, "alpha")
    if ok then
      -- Abrimos Alpha en la ventana actual
      alpha.start(false)

      -- Ahora que Alpha está ocupando el lugar,
      -- borramos el archivo que estaba antes (el buffer previo #)
      vim.schedule(function()
        local prev_buf = vim.fn.bufnr('#')
        if prev_buf ~= -1 and vim.api.nvim_buf_is_valid(prev_buf) then
          vim.cmd("silent! bwipeout " .. prev_buf)
        end
      end)
    end
  else
    -- Si tienes más archivos abiertos, cerramos el actual normalmente
    vim.cmd("bd")
  end
end, { desc = "Cerrar archivo y volver a Alpha si es el último" })

-- Pestañas (Bufferline)
vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { desc = "Siguiente pestaña" })
vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { desc = "Pestaña anterior" })

-- Explorador de archivos
vim.keymap.set('n', '<C-t>', function()
  if ok_tree then
    nt_api.tree.toggle({ focus = true, find_file = true })
  else
    print("NvimTree no cargado")
  end
end, { silent = true, desc = "Alternar Explorador" })

-- =============================================================================
-- LSP e INTELIGENCIA (gd, gr, K)
-- =============================================================================
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Ir a Definición" })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "Ir a Implementación" })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "Ver Referencias" })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Ver Documentación' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Renombrar símbolo" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Acciones de código" })
vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { desc = "Ayuda de firma" })

-- Diagnósticos (Errores)
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Siguiente Error" })
vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Error Anterior" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Ver Error flotante" })
vim.keymap.set('n', '<leader>v', function()
  vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
end, { desc = "Toggle Texto Virtual" })

-- =============================================================================
-- TELESCOPE (Buscadores)
-- =============================================================================
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Buscar Archivos" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Buscar Texto" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Buscar en Buffers" })
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = "Archivos Recientes" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Buscar Ayuda" })
vim.keymap.set("n", "<leader>h", ":Telescope yank_history<CR>", { desc = "Historial Yank" })
vim.keymap.set('n', '<leader>fn', function()
  builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = 'Config de Neovim' })

-- =============================================================================
-- DEBUGGING (DAP)
-- =============================================================================
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = "Breakpoint" })
vim.keymap.set('n', '<leader>dc', dap.continue, { desc = "Debug: Continuar" })
vim.keymap.set('n', '<leader>dn', dap.step_over, { desc = "Debug: Siguiente línea" })
vim.keymap.set('n', '<leader>di', dap.step_into, { desc = "Debug: Entrar" })
vim.keymap.set('n', '<leader>do', dap.step_out, { desc = "Debug: Salir" })
vim.keymap.set('n', '<leader>dr', dap.restart, { desc = "Debug: Reiniciar" })
vim.keymap.set('n', '<leader>du', function() require('dapui').toggle() end, { desc = "DAP UI" })
vim.keymap.set('n', '<leader>gt', function() require('dap-go').debug_test() end, { desc = "Debug Test Go" })

-- =============================================================================
-- TERMINAL Y OTROS
-- =============================================================================
vim.keymap.set('n', '<leader>gg', ':term lazygit<CR>', { desc = "Lazygit" })
vim.keymap.set('n', '<leader>t', ':sp | terminal<CR>i', { desc = 'Abrir Terminal' })
vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]], { desc = "Salir modo terminal" })

-- Snippets
vim.keymap.set({ "i", "s" }, "<C-k>", function() if ls.expand_or_jumpable() then ls.expand_or_jump() end end)
vim.keymap.set({ "i", "s" }, "<C-j>", function() if ls.jumpable(-1) then ls.jump(-1) end end)
-- Pegar en modo visual sin perder lo que tenías copiado
vim.keymap.set("x", "p", 'P', { desc = "Pegar sin sobreescribir registro" })
-- =============================================================================
-- GUÍA Y ADMINISTRACIÓN (Corregido para Windows)
-- =============================================================================

-- Guía de atajos PC (Usa la ruta dinámica del config)
vim.keymap.set('n', '<leader>.', function()
  local path = vim.fn.stdpath("config") .. "/CHEATSHEET.md"
  -- Comprobar si el archivo existe antes de abrirlo
  if vim.fn.filereadable(path) == 1 then
    vim.cmd("vsplit " .. path)
  else
    print("Error: No se encuentra CHEATSHEET.md")
  end
end, { desc = "Ver Guía PC" })

-- Editar Snippets (Ruta inteligente)
vim.keymap.set('n', '<Leader>es', function()
  local path = vim.fn.stdpath("config") .. "/lua/config/misnipet.lua"
  vim.cmd("edit " .. path)
end, { desc = 'Editar Snippets' })

-- Recargar Config (Mejorado para Lazy.nvim)
vim.keymap.set('n', '<Leader>sv', function()
  vim.cmd("source $MYVIMRC")
  print("Configuración recargada!")
end, { desc = 'Recargar Config' })

-- Atajo para volver al Dashboard (Alpha)
vim.keymap.set("n", "<leader>aa", "<cmd>Alpha<cr>", { desc = "Ver Pantalla de Inicio" })

-- Administración
vim.keymap.set('n', '<Leader>cl', ':ClearNvim<CR>', { desc = 'Limpiar Caché' })
