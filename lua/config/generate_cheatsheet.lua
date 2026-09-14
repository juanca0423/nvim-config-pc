local M = {}

--- Extrae los atajos registrados en Neovim y genera CHEATSHEET.md
function M.setup()
	local sheet_path = vim.fn.stdpath("config") .. "/CHEATSHEET.md"

	-- Solo si NO existe (para evitar sobreescribir ediciones manuales)
	if vim.fn.filereadable(sheet_path) == 1 then
		return
	end

	local file = io.open(sheet_path, "w")
	if not file then
		return
	end

	-- Leader
	local leader = vim.g.mapleader or ","

	file:write("# 💻 Neovim PC - Ultimate Cheat Sheet (Sincronizada)\n")
	file:write("## Líder\n")
	file:write("|Comando|Descripción|\n")
	file:write("| :--- | :--- |\n")
	file:write(string.format("| `<leader>` | `%s`|\n\n", leader))

	-- Atajos globales (de mapas.lua)
	file:write("## Archivos y Buffers\n")
	file:write("|Comando|Descripción|\n")
	file:write("| :--- | :--- |\n")
	file:write(string.format("| `<leader>w` | guardar archivo|\n"))
	file:write(string.format("| `<leader>q` | cerrar buffer actual|\n"))
	file:write(string.format("| `<leader>ba` | cerrar todos los demás buffers|\n"))
	file:write(string.format("| `<leader>cp` | copiar ruta completa del archivo actual al portapapeles|\n"))
	file:write(string.format("| `<leader>wb` | abrir `http://localhost:8080` en el navegador|\n"))
	file:write(string.format("| `<Tab>` | siguiente buffer|\n"))
	file:write(string.format("| `<S-Tab>` | buffer anterior|\n"))
	file:write(string.format("| `-` | abrir Oil (explorador de archivos)|\n\n"))

	-- Navegación y layout
	file:write("## Navegación y Layout\n")
	file:write("|Comando|Descripción|\n")
	file:write("| :--- | :--- |\n")
	file:write(string.format("| `<C-Left>` / `<C-Down>` / `<C-Up>` / `<C-Right>` | mover cursor a ventana|\n"))
	file:write(string.format("| `<M-Right>` / `<M-Left>` / `<M-Down>` / `<M-Up>` | agrandar/reducir ventana|\n"))
	file:write(string.format("| `<leader>m` | maximizar la ventana actual|\n"))
	file:write(string.format("| `<leader>=` | igualar tamaño de ventanas|\n"))
	file:write(string.format("| `<leader>zm` | activar/desactivar modo Zen Maximize|\n\n"))

	-- LSP y programación
	file:write("## LSP y Programación\n")
	file:write("|Comando|Descripción|\n")
	file:write("| :--- | :--- |\n")
	file:write(string.format("| `gi` | ir a implementación|\n"))
	file:write(string.format("| `gd` | ir a definición|\n"))
	file:write(string.format("| `gr` | ver referencias|\n"))
	file:write(string.format("| `K` | mostrar hover de LSP|\n"))
	file:write(string.format("| `i <C-k>` | firma de función en modo insert|\n"))
	file:write(string.format("| `<leader>d` | abrir ventana flotante de diagnóstico|\n"))
	file:write(string.format("| `<leader>e` | mostrar error flotante|\n"))
	file:write(string.format("| `]d` | ir al siguiente diagnóstico|\n"))
	file:write(string.format("| `[d` | ir al diagnóstico anterior|\n"))
	file:write(string.format("| `<leader>v` | alternar texto virtual de diagnósticos|\n"))
	file:write(string.format("| `<leader>rn` | renombrar símbolo|\n"))
	file:write(string.format("| `<leader>ca` | acciones de código|\n"))
	file:write(string.format("| `<leader>he` | ayuda flotante personalizada|\n"))
	file:write(string.format("| `gf` | buscar siguiente función / palabra de definición|\n\n"))

	-- Snippets
	file:write("## Snippets\n")
	file:write("|Comando|Descripción|\n")
	file:write("| :--- | :--- |\n")
	file:write(string.format("| `i <C-k>` | expandir o saltar en snippets (luasnip)|\n"))
	file:write(string.format("| `i <C-j>` | saltar hacia atrás en snippets (luasnip)|\n\n"))

	-- Debugging DAP
	file:write("## Debugging (DAP)\n")
	file:write("|Comando|Descripción|\n")
	file:write("| :--- | :--- |\n")
	file:write(string.format("| `<F5>` | iniciar / continuar debug|\n"))
	file:write(string.format("| `<F10>` | step over|\n"))
	file:write(string.format("| `<F11>` | step into|\n"))
	file:write(string.format("| `<F12>` | step out|\n"))
	file:write(string.format("| `<leader>b` | toggle breakpoint|\n"))
	file:write(string.format("| `<leader>B` | set breakpoint condicional|\n"))
	file:write(string.format("| `<leader>du` | toggle UI de DAP|\n"))
	file:write(string.format("| `<leader>dq` | detener debugger y cerrar UI|\n"))
	file:write(string.format("| `<leader>db` | activar/desactivar breakpoint|\n"))
	file:write(string.format("| `<leader>dc` | continuar ejecución|\n"))
	file:write(string.format("| `<leader>dn` | step over (paso siguiente)|\n"))
	file:write(string.format("| `<leader>di` | step into (entrar)|\n"))
	file:write(string.format("| `<leader>dr` | reiniciar DAP / Abrir REPL|\n"))
	file:write(string.format("| `<leader>gt` | ejecutar test Go con `dap-go`|\n"))
	file:write(string.format("| `<leader>dh` | hover variable en DAP|\n"))
	file:write(string.format("| `<leader>de` | evaluar expresión flotante DAP|\n\n"))

	-- Terminal y ToggleTerm
	file:write("## Terminal y ToggleTerm\n")
	file:write("|Comando|Descripción|\n")
	file:write("| :--- | :--- |\n")
	file:write(string.format("| `<C-\\>` | abrir/cerrar terminal general|\n"))
	file:write(string.format("| `<leader>te` | abrir terminal dividida|\n"))
	file:write(string.format("| `<Esc><Esc>` | salir de modo terminal|\n\n"))

	-- Git / Gitsigns
	file:write("## Git / Gitsigns\n")
	file:write("|Comando|Descripción|\n")
	file:write("| :--- | :--- |\n")
	file:write(string.format("| `]h` | siguiente hunk|\n"))
	file:write(string.format("| `[h` | hunk anterior|\n"))
	file:write(string.format("| `<leader>hp` | previsualizar hunk|\n"))
	file:write(string.format("| `<leader>hb` | blame completo de línea|\n"))
	file:write(string.format("| `<leader>hd` | diff del archivo|\n\n"))

	-- AI / CodeCompanion
	file:write("## 🤖 AI (CodeCompanion + Ollama)\n")
	file:write("|Comando|Descripción|\n")
	file:write("| :--- | :--- |\n")
	file:write(string.format("| `<leader>ai` | Toggle AI Chat|\n"))
	file:write(string.format("| `<leader>ap` | AI Actions (v)|\n"))
	file:write(string.format("| `<leader>ae` | AI Inline Command|\n\n"))

	-- Harpoon
	file:write("## 📍 Harpoon\n")
	file:write("|Comando|Descripción|\n")
	file:write("| :--- | :--- |\n")
	file:write(string.format("| `<leader>a` | marcar archivo|\n\n"))

	-- Telescope y búsqueda
	file:write("## 🔭 Telescope y Búsqueda\n")
	file:write("|Comando|Descripción|\n")
	file:write("| :--- | :--- |\n")
	file:write(string.format("| `<leader>ff` | buscar archivos|\n"))
	file:write(string.format("| `<leader>fg` | buscar texto con live grep|\n"))
	file:write(string.format("| `<leader>fb` | listar buffers|\n"))
	file:write(string.format("| `<leader>fr` | abrir archivos recientes|\n"))
	file:write(string.format("| `<leader>h` | historial de yank con Telescope|\n"))
	file:write(string.format("| `<leader>td` | buscar TODOs con TodoTelescope|\n"))
	file:write(string.format("| `<leader>fs` | símbolos del documento con Telescope|\n"))
	file:write(string.format("| `<leader>fS` | símbolos del workspace dinámicos con Telescope|\n"))
	file:write(string.format("| `<leader>fp` | proyectos recientes con Snacks|\n"))
	file:write(string.format("| `<leader>hd` | buscar ayuda/documentación con Snacks|\n\n"))

	-- Base de datos
	file:write("## 🗄️ Base de Datos\n")
	file:write("|Comando|Descripción|\n")
	file:write("| :--- | :--- |\n")
	file:write(string.format("| `<leader>rq` | ejecutar SQL con `DB`|\n"))
	file:write(string.format("| `<leader>bj` | ejecutar SQL y mostrar resultado en JSON|\n\n"))

	-- Docker y Go
	file:write("## 🐳 Docker y Go\n")
	file:write("|Comando|Descripción|\n")
	file:write("| :--- | :--- |\n")
	file:write(string.format("| `<leader>gp` | Go Test: Paquete Actual|\n"))
	file:write(string.format("| `<leader>gc` | Go: Ver Cobertura (HTML)|\n"))
	file:write(string.format("| `<leader>dps` | mostrar estado de Docker (`docker ps`)|\n"))
	file:write(string.format("| `<leader>ddo` | ejecutar `docker-compose down`|\n"))
	file:write(string.format("| `<leader>dk` | reiniciar app Go (`docker restart go_web_app`)|\n"))
	file:write(
		string.format(
			"| `<leader>drb` | reconstruir y levantar Docker (`docker-compose down && docker-compose up --build -d`)|\n"
		)
	)
	file:write(string.format("| `<leader>gg` | abrir `lazygit` en terminal integrada|\n\n"))

	-- Config y utilidades
	file:write("## ⚙️ Config y Utilidades\n")
	file:write("|Comando|Descripción|\n")
	file:write("| :--- | :--- |\n")
	file:write(string.format("| `<leader>sv` | recargar configuración (`source $MYVIMRC`)|\n"))
	file:write(string.format("| `<leader>cl` | limpiar caché de Neovim|\n"))
	file:write(string.format("| `<leader>fd` | formatear buffer manualmente con `conform`|\n"))
	file:write(string.format("| `<leader>sf` | formatear archivo SQL con `conform`|\n"))
	file:write(string.format("| `<leader>.` | abrir la guía de cheatsheet si existe|\n"))
	file:write(string.format("| `<leader>ud` | borrar la guía de cheatsheet (`CHEATSHEET.md`)|\n\n"))

	-- Autocomandos útiles
	file:write("## 🔧 Autocomandos\n")
	file:write("|Comando|Descripción|\n")
	file:write("| :--- | :--- |\n")
	file:write(string.format("| `]]` | saltar al siguiente bloque `{{#...}}` / `{{/...}}` (Handlebars)|\n"))
	file:write(string.format("| `[[` | saltar al bloque anterior `{{#...}}` / `{{/...}}` (Handlebars)|\n\n"))

	file:write("---\n")
	file:close()
	print("✅ Nueva CHEATSHEET.md generada con todos los atajos.")
end

return M
