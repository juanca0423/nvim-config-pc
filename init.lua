vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.netrw_liststyle = 3
-- 0. CONFIGURACIÓN INICIAL
vim.g.mapleader = ","

-- Shell Windows (Optimizado una sola vez)
if vim.fn.has("win32") == 1 then
  -- Optimización para que la shell de Windows responda rápido
  vim.o.shell = "cmd.exe"
  vim.o.shellcmdflag = "/c"
  vim.opt.shell = "powershell.exe"
  vim.opt.shellcmdflag =
  "-NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  vim.opt.shellredir = "2>&1 | Out-File -Encoding UTF8 %s"
  vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
  vim.g.python3_host_prog = nil
end

-- 1. GESTIÓN DE PLUGINS (Lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  rocks = { enabled = false },
  defaults = { lazy = false }, -- Mantenemos lazy=false para que no se te rompa nada
  performance = {
    cache = { enabled = true },
  },
})

-- 2. CARGA DE CONFIGURACIONES EXTERNAS
-- El orden es vital: primero opciones, luego mapas
require("opciones")
require("mapas")
require("config.misnipet")
require("config.autocomandos")

-- 3. ESTÉTICA RÁPIDA (Solo highlights)
vim.cmd('highlight CursorLineNr guifg=#FAB387 gui=bold')
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      vim.schedule(function()
        -- 1. Buscamos el buffer 2 (o cualquier otro que no sea Alpha)
        local bufs = vim.api.nvim_list_bufs()
        for _, buf in ipairs(bufs) do
          local name = vim.api.nvim_buf_get_name(buf)
          local ft = vim.bo[buf].filetype

          -- Si el buffer es el [No Name] (sin nombre y sin tipo) y NO es Alpha
          if ft ~= "alpha" and name == "" and vim.api.nvim_buf_is_valid(buf) then
            -- 2. Lo borramos de la existencia
            pcall(vim.api.nvim_buf_delete, buf, { force = true })
          end
        end

        -- 3. Forzamos el foco de vuelta al buffer de Alpha
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.bo[buf].filetype == "alpha" then
            vim.api.nvim_set_current_buf(buf)
            break
          end
        end
      end)
    end
  end,
})
