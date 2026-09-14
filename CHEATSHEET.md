# 💻 Neovim PC - Ultimate Cheat Sheet (Sincronizada)
## Líder
|Comando|Descripción|
| :--- | :--- |
| `<leader>` | `,`|

## Archivos y Buffers
|Comando|Descripción|
| :--- | :--- |
| `<leader>w` | guardar archivo|
| `<leader>q` | cerrar buffer actual|
| `<leader>ba` | cerrar todos los demás buffers|
| `<leader>cp` | copiar ruta completa del archivo actual al portapapeles|
| `<leader>wb` | abrir `http://localhost:8080` en el navegador|
| `<Tab>` | siguiente buffer|
| `<S-Tab>` | buffer anterior|
| `-` | abrir Oil (explorador de archivos)|

## Navegación y Layout
|Comando|Descripción|
| :--- | :--- |
| `<C-Left>` / `<C-Down>` / `<C-Up>` / `<C-Right>` | mover cursor a ventana|
| `<M-Right>` / `<M-Left>` / `<M-Down>` / `<M-Up>` | agrandar/reducir ventana|
| `<leader>m` | maximizar la ventana actual|
| `<leader>=` | igualar tamaño de ventanas|
| `<leader>zm` | activar/desactivar modo Zen Maximize|

## LSP y Programación
|Comando|Descripción|
| :--- | :--- |
| `gi` | ir a implementación|
| `gd` | ir a definición|
| `gr` | ver referencias|
| `K` | mostrar hover de LSP|
| `i <C-k>` | firma de función en modo insert|
| `<leader>d` | abrir ventana flotante de diagnóstico|
| `<leader>e` | mostrar error flotante|
| `]d` | ir al siguiente diagnóstico|
| `[d` | ir al diagnóstico anterior|
| `<leader>v` | alternar texto virtual de diagnósticos|
| `<leader>rn` | renombrar símbolo|
| `<leader>ca` | acciones de código|
| `<leader>he` | ayuda flotante personalizada|
| `gf` | buscar siguiente función / palabra de definición|

## Snippets
|Comando|Descripción|
| :--- | :--- |
| `i <C-k>` | expandir o saltar en snippets (luasnip)|
| `i <C-j>` | saltar hacia atrás en snippets (luasnip)|

## Debugging (DAP)
|Comando|Descripción|
| :--- | :--- |
| `<leader>db` | activar/desactivar breakpoint|
| `<leader>dc` | continuar ejecución|
| `<leader>dn` | step over (paso siguiente)|
| `<leader>di` | step into (entrar)|
| `<leader>dr` | reiniciar DAP|
| `<leader>da` | repetir último test en DAP|
| `<leader>gt` | ejecutar test Go con `dap-go`|
| `<leader>dh` | hover variable en DAP|
| `<leader>dq` | detener debugger / sesión DAP|
| `<leader>B` | set breakpoint condicional|

## Terminal y ToggleTerm
|Comando|Descripción|
| :--- | :--- |
| `<C-\>` | abrir/cerrar terminal general|
| `<leader>te` | abrir terminal dividida|
| `<Esc><Esc>` | salir de modo terminal|

## Git / Gitsigns
|Comando|Descripción|
| :--- | :--- |
| `]h` | siguiente hunk|
| `[h` | hunk anterior|
| `<leader>hp` | previsualizar hunk|
| `<leader>hb` | blame completo de línea|
| `<leader>hd` | diff del archivo|

## 🤖 AI (CodeCompanion + Ollama)
|Comando|Descripción|
| :--- | :--- |
| `<leader>ai` | Toggle AI Chat|
| `<leader>ap` | AI Actions (v)|
| `<leader>ae` | AI Inline Command|

## 📍 Harpoon
|Comando|Descripción|
| :--- | :--- |
| `<leader>a` | marcar archivo|

## 🔭 Telescope y Búsqueda
|Comando|Descripción|
| :--- | :--- |
| `<leader>ff` | buscar archivos|
| `<leader>fg` | buscar texto con live grep|
| `<leader>fb` | listar buffers|
| `<leader>fr` | abrir archivos recientes|
| `<leader>h` | historial de yank con Telescope|
| `<leader>td` | buscar TODOs con TodoTelescope|
| `<leader>fs` | símbolos del documento con Telescope|
| `<leader>fS` | símbolos del workspace dinámicos con Telescope|
| `<leader>fp` | proyectos recientes con Snacks|
| `<leader>hd` | buscar ayuda/documentación con Snacks|

## 🗄️ Base de Datos
|Comando|Descripción|
| :--- | :--- |
| `<leader>rq` | ejecutar SQL con `DB`|
| `<leader>bj` | ejecutar SQL y mostrar resultado en JSON|

## 🐳 Docker y Go
|Comando|Descripción|
| :--- | :--- |
| `<leader>gp` | Go Test: Paquete Actual|
| `<leader>gc` | Go: Ver Cobertura (HTML)|
| `<leader>dps` | mostrar estado de Docker (`docker ps`)|
| `<leader>ddo` | ejecutar `docker-compose down`|
| `<leader>dk` | reiniciar app Go (`docker restart go_web_app`)|
| `<leader>drb` | reconstruir y levantar Docker (`docker-compose down && docker-compose up --build -d`)|
| `<leader>gg` | abrir `lazygit` en terminal integrada|

## ⚙️ Config y Utilidades
|Comando|Descripción|
| :--- | :--- |
| `<leader>sv` | recargar configuración (`source $MYVIMRC`)|
| `<leader>cl` | limpiar caché de Neovim|
| `<leader>fd` | formatear buffer manualmente con `conform`|
| `<leader>sf` | formatear archivo SQL con `conform`|
| `<leader>.` | abrir la guía de cheatsheet si existe|
| `<leader>ud` | borrar la guía de cheatsheet (`CHEATSHEET.md`)|

## 🔧 Autocomandos
|Comando|Descripción|
| :--- | :--- |
| `]]` | saltar al siguiente bloque `{{#...}}` / `{{/...}}` (Handlebars)|
| `[[` | saltar al bloque anterior `{{#...}}` / `{{/...}}` (Handlebars)|

---
