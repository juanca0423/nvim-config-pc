# 💻 Neovim PC - Ultimate Cheat Sheet (Sincronizada)
## Líder
|Comando|Descripcióndocker|
| :--- | :--- |
| `<leader>` | `,`|

## Archivos y Buffers
|Comando|Descripcióndocker|
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
|Comando|Descripcióndocker|
| :--- | :--- |
| `<C-Left>` / `<C-Down>` / `<C-Up>` / `<C-Right>` | mover cursor a ventana|
| `<M-Right>` / `<M-Left>` / `<M-Down>` / `<M-Up>` | agrandar/reducir ventana|
| `<leader>m` | maximizar la ventana actual|
| `<leader>|` | equalizar tamaño de ventanas|
| `<leader>zm` | activar/desactivar modo Zen Maximize|

## LSP y Programación
|Comando|Descripcióndocker|
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
|Comando|Descripcióndocker|
| :--- | :--- |
| `i <C-k>` | expandir o saltar en snippets (luasnip)|
| `i <C-j>` | saltar hacia atrás en snippets (luasnip)|

## Debugging (DAP)
|Comando|Descripcióndocker|
| :--- | :--- |
| `<leader>db` | activar/desactivar breakpoint|
| `<leader>dc` | continuar ejecución|
| `<leader>dn` | step over (paso siguiente)|
| `<leader>di` | step into (entrar)|
| `<leader>dr` | reiniciar DAP|
| `<leader>gt` | ejecutar test Go con `dap-go`|
| `<leader>dh` | hover variable en DAP|
| `<leader>de` | abrir REPL de DAP|
| `F5` | iniciar / continuar debug|
| `F10` | step over|
| `F11` | step into|
| `F12` | step out|
| `<leader>b` | toggle breakpoint|
| `<leader>B` | set breakpoint condicional|
| `<leader>du` | toggle UI de DAP|

## Terminal y ToggleTerm
|Comando|Descripcióndocker|
| :--- | :--- |
| `<C-\>` | abrir/cerrar terminal general|
| `<leader>tf` | abrir terminal flotante|
| `<leader>th` | abrir terminal horizontal|
| `<Esc><Esc>` | salir de modo terminal|
| `jk` | salir de modo terminal|
| `t<C-h>` / `t<C-j>` / `t<C-k>` / `t<C-l>` | navegar entre ventanas desde terminal|

## Git / Gitsigns
|Comando|Descripcióndocker|
| :--- | :--- |
| `]h` | siguiente hunk|
| `[h` | hunk anterior|
| `<leader>hp` | previsualizar hunk|
| `<leader>hb` | blame completo de línea|
| `<leader>hd` | diff del archivo|

## 🤖 AI (CodeCompanion + Ollama)
|Comando|Descripcióndocker|
| :--- | :--- |
| `<leader>ai` | Toggle AI Chat|
| `<leader>ap` | AI Actions (v)|n| `<leader>ae` | AI Inline Command|

## 🌐 Kulala (HTTP Client)
|Comando|Descripcióndocker|
| :--- | :--- |
| `<leader>hr` | Ejecutar petición HTTP|
| `<leader>hv` | Cambiar vista (Cuerpo/Headers)|
| `<leader>hn` | Siguiente petición|
| `<leader>hp` | Petición anterior|

## 📍 Harpoon
|Comando|Descripcióndocker|
| :--- | :--- |
| `<leader>a` | marcar archivo|
| `<C-e>` | abrir menú rápido de Harpoon|
| `<A-1>` … `<A-5>` | saltar a marca Harpoon 1..5|

## 🔭 Telescope y Búsqueda
|Comando|Descripcióndocker|
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

## 🍿 Snacks
|Comando|Descripcióndocker|
| :--- | :--- |
| `<leader>t` | explorador Snacks|
| `<leader>lg` | abrir Lazygit desde Snacks|
| `<leader>aa` | abrir dashboard Snacks|

## ⚠️ Trouble
|Comando|Descripcióndocker|
| :--- | :--- |
| `<leader>xx` | Proyecto: Errores|
| `<leader>xd` | Archivo Actual: Errores|
| `<leader>xr` | LSP: Referencias|
| `<leader>xt` | Lista de TODOs|
| `<leader>xq` | Quickfix List|

## 🔍 Spectre (Buscar/Reemplazar)
|Comando|Descripcióndocker|
| :--- | :--- |
| `<leader>S` | abrir Spectre (buscar/reemplazar)|

## 🗄️ Base de Datos
|Comando|Descripcióndocker|
| :--- | :--- |
| `<leader>bd` | Toggle UI de Base de Datos|
| `<leader>sq` | Ejecutar Query SQL|
| `<leader>rq` | ejecutar SQL con `DB`|
| `<leader>bj` | ejecutar SQL y mostrar resultado en JSON|

## 🐳 Docker
|Comando|Descripcióndocker|
| :--- | :--- |
| `<leader>dps` | mostrar estado de Docker (`docker ps`)|
| `<leader>ddo` | ejecutar `docker-compose down`|
| `<leader>dk` | reiniciar app Go (`docker restart go_web_app`)|
| `<leader>drb` | reconstruir y levantar Docker (`docker-compose down && docker-compose up --build -d`)|
| `<leader>gg` | abrir `lazygit` en terminal integrada|

## 📋 Yanky (Portapapeles)
|Comando|Descripcióndocker|
| :--- | :--- |
| `p` / `P` | pegar desde Yanky|
| `<M-p>` | ciclo adelante en Yanky|
| `<M-n>` | ciclo atrás en Yanky|

## 🧪 Neotest
|Comando|Descripcióndocker|
| :--- | :--- |
| `nnr` | correr test cercano|
| `nnf` | correr tests del archivo actual|
| `nna` | correr toda la suite|
| `nns` | alternar summary de Neotest|
| `nno` | abrir salida del último test|
| `nnp` | alternar panel de salida|

## ⚙️ Config y Utilidades
|Comando|Descripcióndocker|
| :--- | :--- |
| `<leader>sv` | recargar configuración (`source $MYVIMRC`)|
| `<leader>cl` | limpiar caché de Neovim|
| `<leader>f` | formatear buffer manualmente con `conform`|
| `<leader>sf` | formatear archivo SQL con `conform`|
| `<leader>.` | abrir la guía de cheatsheet si existe|
| `<leader>ud` | borrar la guía de cheatsheet (`CHEATSHEET.md`)|

## 🔧 Autocomandos
|Comando|Descripcióndocker|
| :--- | :--- |
| `]]` | saltar al siguiente bloque `{{#...}}` / `{{/...}}` (Handlebars)|
| `[[` | saltar al bloque anterior `{{#...}}` / `{{/...}}` (Handlebars)|

---
