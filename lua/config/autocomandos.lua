-- ==========================================================================
-- GRUPOS DE AUTOCOMANDOS (Evita duplicados al recargar)
-- ==========================================================================
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- 1. DETECCIÓN DE RAÍZ DEL PROYECTO
local function set_project_root()
  local markers = { "go.mod", "package.json", ".git", "Makefile" }
  local root = vim.fs.find(markers, { upward = true, path = vim.fn.expand("%:p:h") })[1]
  if root then
    local dir = vim.fs.dirname(root)
    vim.cmd("lcd " .. dir)
  end
end

vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup("project_root"),
  callback = function()
    if vim.fn.argc() > 0 then set_project_root() end
  end,
})

-- 2. FORMATEO Y LIMPIEZA AL GUARDAR (Unificado)
-- Esto combina la limpieza de espacios y el formateo LSP en un solo paso
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("format_on_save"),
  pattern = { "*.go", "*.js", "*.ts", "*.hbs", "*.html", "*.css", "*.lua" },
  callback = function()
    -- Eliminar espacios al final
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)

    -- Formatear con LSP (solo si hay un servidor activo)
    vim.lsp.buf.format({ timeout_ms = 1000 })
  end,
})

-- 3. AJUSTES PARA HANDLEBARS Y COLORES
vim.filetype.add({ extension = { hbs = "handlebars" } })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("hbs_fix"),
  pattern = "*.hbs",
  callback = function()
    vim.bo.filetype = "handlebars"
    pcall(vim.treesitter.start)
  end,
})

-- 4. RESALTAR AL COPIAR
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function() vim.highlight.on_yank({ timeout = 200 }) end,
})

-- 5. CERRAR NVIM-TREE AUTOMÁTICAMENTE
vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup("nvim_tree_close"),
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
      vim.cmd("quit")
    end
  end
})

-- ==========================================================================
-- FUNCIONES ADICIONALES (Mantenemos tus herramientas)
-- ==========================================================================

-- Logs de Docker
vim.keymap.set("n", "<leader>lg", function()
  vim.cmd("botright 10split")
  vim.fn.termopen("docker logs -f go_web_app")
  vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true, silent = true })
  vim.cmd("normal G")
end, { desc = "Ver logs Docker" })

-- Generador de CheatSheet (SOLO SI NO EXISTE)
-- Esto evita escribir en el disco cada vez que entras
local sheet_path = vim.fn.stdpath("config") .. "/CHEATSHEET.md"
local f = io.open(sheet_path, "r")
if f == nil then
  local file = io.open(sheet_path, "w")
  if file then
    file:write("# 💻 Neovim PC - Ultimate Cheat Sheet\n\n(Tu tabla de atajos aquí...)")
    file:close()
  end
else
  f:close()
end

-- Forzamos la creación/actualización con la nueva tabla
local file = io.open(sheet_path, "w")
if file then
  file:write([[

# 💻 Neovim PC - Ultimate Cheat Sheet (v0.11)


### 🚀 Navegación y Ventanas
| Atajo | Acción | Contexto |
| :--- | :--- | :--- |
| `-` | Abrir Oil (Explorador de texto) | Archivos |
| `Ctrl + t`| Abrir/Cerrar Nvim-Tree | Explorador |
| `Tab / S-Tab`| Siguiente / Anterior pestaña | Buffers |
| `<leader>q` | Cerrar pestaña actual | General |
|<leader>ba|Cerrar los demás buffers|General|


### 🪟 Navegación de Ventanas
|Atajo|Acción|Teclas Vim|
| :--- | :--- | :--- |
|`<C-←>`|Ventana Izquierda|h|
|`<C-↓>`|Ventana Abajo|j|
|`<C-↑>`|Ventana Arriba|k|
|`<C-→>`|Ventana Derecha|l|


### 🔍 Buscadores y Reemplazo
| Atajo | Acción | Plugin |
| :--- | :--- | :--- |
| `<leader>ff` | Buscar archivos por nombre | Telescope |
| `<leader>fg` | Buscar palabras (Live Grep) | Telescope |
|`<leader>fb`|Buscar en Buffers|Telescope|
|`<leader>fr`|Archivos Recientes|Telescope|
|`<leader>fh`|Buscar Ayuda|Telescope|
|`<leader>h`|Historial Yank|Telescope|
|`<leader>fn`|Config de Neovim|Telescope|
| `<leader>S` |Buscar y Reemplazar Global | Spectre |
| `s` | Saltar a cualquier letra | Flash |
| `S` | Selección inteligente | Flash |


### 🧠 Inteligencia de Código (LSP)
| Atajo | Acción |
| :--- | :--- |
| `gd` | Ir a la definición |
|`gi`|Ir a Implementación|
|`K` | Ver documentación |
| `gr` | Ver referencias |
|`<leader>rn` | Renombrar (Todo el proyecto) |
|`<C-k>`|Ayuda de firma|
| `]d / [d` | Sig / Ant Error |
|`<leader>ca` | Code Action (Fix) |
| `<leader>xx` | Trouble: Ver lista de errores |
|`<leader>xd` | Errores del archivo |


### 🎣 Harpoon (Tus Favoritos)
| Atajo | Acción |
| :--- | :--- |
| `<leader>a` | Marcar archivo actual |
| `<C-e>` | Ver menú de marcas |
| `Alt + 1..5` |Salto instantáneo a marca 1..5 |


### 🐞 Debugging & Testing
| Atajo | Acción | Plugin |
| :--- | :--- | :--- |
| `<leader>db` | Poner Breakpoint | DAP |
| `<leader>dc` | Continuar / Iniciar | DAP |
| `<leader>du` | Toggle Interfaz Debug | DAP UI |
|`<leader>dn`|Debug: Siguiente línea|DAP|
|`<leader>di`|Debug: Entrar|DAP|
|`<leader>do`|Debug: Salir|DAP|
|`<leader>dr`|Debug: Reiniciar|DAP|
|`<leader>gt`|Debug Test Go|Testing|
| `<leader>tn` | Ejecutar Test cercano | Vim-Test |
| `<leader>tf` | Ejecutar Test del archivo | Vim-Test |
|`<leader>e`|Ver Error flotante|
|`<leader>v`|Toggle Texto Virtual|


### 📝 Edición Pro
| Atajo | Acción | Plugin |
| :--- | :--- | :--- |
| `p / P` | Pegar con historial | Yanky |
| `Alt + n / p`| Ciclar historial de copiado | Yanky |
| `<leader>nf` | Documentar Función | Neogen |
| `<leader>nc` | Documentar Clase/Struct | Neogen |
| `za / zk` | Plegar / Vista previa pliegue | UFO |


### 🌐 Sistema
| Atajo | Acción |
| :--- | :--- |
| `<leader>w` | Guardar archivo |
| `<leader>sv`| Recargar configuración Neovim |
| `<leader>` | Ver esta Guía |
| `gg` | Lazygit (Terminal) |
| `<leader>lg`| Ver Logs de Docker (Go App) |
|`<leader>t|Abrir terminal|
|`<leader>aa`|Ver Pantalla de Inicio|
|`<leader>cl`|Limpiar Cache|


### 🐳 Docker
| Atajo | Acción |
| :--- | :--- |
| `<leader>lg` | Docker: Logs |
| `<leader>dup` | Docker Compose Up |
| `<leader>ddown` | Docker Compose Down |
| `<leader>dps` | Ver Estado Docker |
| `<leader>dr` | Reiniciar App Go |
| `<leader>drb` | Docker: Rebuild |


]])
  file:close()
end

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local root = vim.fs.find({ "go.mod", "package.json", ".git" }, { upward = true, path = vim.fn.expand("%:p:h") })[1]
    if root then
      local root_dir = vim.fs.dirname(root)
      vim.fn.chdir(root_dir) -- Cambia el directorio de Neovim a la raíz del proyecto
    end
  end,
})

local function docker_float_cmd(cmd)
  -- Usamos ToggleTerm para ejecutar el comando sin romper el layout
  local Terminal = require('toggleterm.terminal').Terminal
  local docker_term = Terminal:new({
    cmd = cmd,
    close_on_exit = false, -- Para que puedas leer el resultado antes de cerrar
    direction = "float",
    on_open = function(term)
      -- Cerramos con 'q'
      vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = term.bufnr, silent = true })
    end,
  })
  docker_term:toggle()
end

-- Nuevos atajos que NO achican la pantalla

vim.keymap.set("n", "<leader>lg", function()
  docker_float_cmd("docker logs -f go_web_app")
end, { desc = "Docker: Logs" })


-- ATAJOS DE DOCKER
-- Levantar contenedores (Docker Compose Up)
vim.keymap.set("n", "<leader>dup", function()
  docker_float_cmd("docker-compose up -d")
end, { desc = "Docker Compose Up" })

-- Bajar contenedores (Docker Compose Down)
vim.keymap.set("n", "<leader>ddown", function()
  docker_float_cmd("docker-compose down")
end, { desc = "Docker Compose Down" })

-- Ver estado de contenedores (Docker PS)
vim.keymap.set("n", "<leader>dps", function()
  docker_float_cmd("docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'")
end, { desc = "Ver Estado Docker" })

-- Reiniciar el contenedor de Go específicamente
vim.keymap.set("n", "<leader>dr", function()
  docker_float_cmd("docker restart go_web_app")
end, { desc = "Reiniciar App Go" })

vim.keymap.set("n", "<leader>drb", function()
  docker_float_cmd("docker-compose down && docker-compose up --build -d")
end, { desc = "Docker: Rebuild" })

-- Si cerramos el último buffer, abrir Alpha automáticamente
vim.api.nvim_create_autocmd("BufDelete", {
  callback = function()
    vim.schedule(function()
      -- Contamos cuántos buffers reales quedan
      local bufs = vim.api.nvim_list_bufs()
      local loaded_bufs = 0
      for _, buf in ipairs(bufs) do
        if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
          loaded_bufs = loaded_bufs + 1
        end
      end

      -- Si no quedan buffers abiertos, llamamos a Alpha
      if loaded_bufs == 0 then
        pcall(vim.cmd, "Alpha")
      end
    end)
  end,
})
