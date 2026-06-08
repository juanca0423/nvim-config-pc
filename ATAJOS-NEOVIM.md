# Atajos de teclado de Neovim

## General
- `<leader>` = `,`
- `<Esc><Esc>` (modo terminal) = salir a modo normal desde terminal

## Archivos y buffers
- `<leader>w` = guardar archivo
- `<leader>q` = cerrar buffer actual
- `<leader>ba` = cerrar todos los demás buffers
- `<leader>cp` = copiar ruta completa del archivo actual al portapapeles
- `<leader>wb` = abrir `http://localhost:8080` en el navegador

## Ventanas y layout
- `<C-Left>` = mover cursor a ventana izquierda
- `<C-Down>` = mover cursor a ventana inferior
- `<C-Up>` = mover cursor a ventana superior
- `<C-Right>` = mover cursor a ventana derecha
- `<M-Right>` = agrandar ventana horizontal (+5)
- `<M-Left>` = reducir ventana horizontal (-5)
- `<M-Down>` = agrandar ventana vertical (+5)
- `<M-Up>` = reducir ventana vertical (-5)
- `<leader>m` = maximizar la ventana actual (`<C-w>|<C-w>_`)
- `<leader>=` = equalizar tamaño de ventanas (`<C-w>=`)
- `<leader>zm` = activar/desactivar modo Zen Maximize

## LSP y programación
- `gi` = ir a implementación
- `gd` = ir a definición
- `gr` = ver referencias
- `K` = mostrar hover de LSP
- `<leader>d` = abrir ventana flotante de diagnóstico
- `<leader>e` = mostrar error flotante
- `]d` = ir al siguiente diagnóstico
- `[d` = ir al diagnóstico anterior
- `<leader>v` = alternar texto virtual de diagnósticos
- `<leader>rn` = renombrar símbolo
- `<leader>ca` = acciones de código
- `i <C-k>` = firma de función en modo insert

## Snippets
- `i <C-k>` = expandir o saltar en snippets (luasnip)
- `i <C-j>` = saltar hacia atrás en snippets (luasnip)

## Debugging (DAP)
- `<leader>db` = activar/desactivar breakpoint
- `<leader>dc` = continuar ejecución
- `<leader>dn` = step over (paso siguiente)
- `<leader>di` = step into (entrar)
- `<leader>dr` = reiniciar DAP
- `<leader>gt` = ejecutar test Go con `dap-go`

## Docker y terminal
- `<leader>dps` = mostrar estado de Docker (`docker ps`)
- `<leader>ddo` = ejecutar `docker-compose down`
- `<leader>dk` = reiniciar app Go (`docker restart go_web_app`)
- `<leader>drb` = reconstruir y levantar Docker (`docker-compose down && docker-compose up --build -d`)
- `<leader>gg` = abrir `lazygit` en terminal integrada
- `<leader>te` = abrir terminal en split horizontal

## SQL
- `<leader>rq` = ejecutar SQL con `DB`
- `<leader>bj` = ejecutar SQL y mostrar resultado en JSON

## Telescope y búsqueda
- `<leader>ff` = buscar archivos
- `<leader>fg` = buscar texto con live grep
- `<leader>fb` = listar buffers
- `<leader>fr` = abrir archivos recientes
- `<leader>h` = historial de yank con Telescope
- `<leader>td` = buscar TODOs con TodoTelescope
- `<leader>fs` = símbolos del documento con Telescope
- `<leader>fS` = símbolos del workspace dinámicos con Telescope
- `<leader>fp` = proyectos recientes con Snacks
- `<leader>hd` = buscar ayuda/documentación con Snacks

## Configuración y utilidades
- `<leader>sv` = recargar configuración (`source $MYVIMRC`)
- `<leader>cl` = limpiar caché de Neovim
- `<leader>f` = formatear buffer manualmente con `conform`
- `<leader>sf` = formatear archivo SQL con `conform`
- `<leader>.` = abrir la guía de cheatsheet si existe
- `<leader>ud` = borrar la guía de cheatsheet (`CHEATSHEET.md`)

## Autocomandos útiles
- En archivos `handlebars`:
  - `]]` = saltar al siguiente bloque `{{#...}}` / `{{/...}}`
  - `[[` = saltar al bloque anterior `{{#...}}` / `{{/...}}`

## Atajo adicional de búsqueda
- `gf` = buscar la siguiente función o `func`/`function` usando una búsqueda mejorada

---

### Nota
Este archivo resume los atajos definidos en tu `init.lua` y en `lua/mapas.lua`.
Si quieres actualizarlo directamente en Neovim, abre `ATAJOS-NEOVIM.md` y guarda los cambios.