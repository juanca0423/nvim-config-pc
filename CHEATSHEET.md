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
| `<leader>ba` | cerrar otros buffers|
| `<leader>cp` | copiar ruta completa del archivo actual|
| `<leader>wb` | abrir `http://localhost:8080`|
| `Tab` | siguiente buffer|
| `Shift+Tab` | buffer anterior|
| `-` | abrir Oil (explorador de archivos)| 
                   
## Navegación y Layout
Comando|Descripcióndocker|
| :--- | :--- |
| `<C-Left>` / `<C-Down>` / `<C-Up>` / `<C-Right>` | mover entre ventanas|
| `<M-Right>` / `<M-Left>` / `<M-Down>` / `<M-Up>` | redimensionar ventanas|
| `<leader>m` | maximizar ventana actual|    
| `<leader>|` | igualar tamaño de ventanas|    
| `<leader>zm` | modo Zen Maximize|    
                    
## LSP y Diagnósticos
|Comando|Descripcióndocker|
| :--- | :--- |
| `gi` | ir a implementación|    
| `gd` | ir a definición|    
| `gr` | ver referencias|    
| `K` | hover / documentación|    
| `i<C-k>` | firma de función (LSP)|    
| `<leader>d` | diagnóstico flotante|    
| `<leader>e` | error flotante|    
| `]d` / `[d` | siguiente/anterior diagnóstico|    
| `<leader>v` | alternar texto virtual de diagnósticos|
| `<leader>rn` | renombrar símbolo|    
| `<leader>ca` | acción de código|    
| `<leader>he` | ayuda flotante personalizada|    
                     
## Snippets
|Comando|Descripcióndocker|
| :--- | :--- |
| `i<C-k>` | expandir o saltar snippet| 
| `i<C-j>` | saltar hacia atrás en snippet|
                   
## Debugging (DAP)
|Comando|Descripcióndocker|
| :--- | :--- |
| `<leader>db` | toggle breakpoint|
| `<leader>dc` | continuar DAP|
| `<leader>dn` | step over|
| `<leader>di` | step into|
| `<leader>dr` | reiniciar DAP|
| `<leader>gt` | debug test Go (`dap-go`)|
| `<leader>dh` | hover variable en DAP|
| `<leader>de` | abrir REPL de DAP|
| `F5` | iniciar / continuar debug|
| `F10` | step over|
| `F11` | step into|
| `F12` | step out|
| `<leader>b` | toggle breakpoint|
| `<leader>B` | set breakpoint condicional|
| `<leader>du` | toggle UI de DAP|
                     
## Git / Gitsigns
|Comando|Descripcióndocker|
| :--- | :--- |
| `]h` | siguiente hunk|
| `[h` | hunk anterior|
| `<leader>hp` | previsualizar hunk|
| `<leader>hb` | blame completo de línea|
| `<leader>hd` | diff del archivo|
                     
## Terminal y ToggleTerm
|Comando|Descripcióndocker|
| :--- | :--- |
| `<C-\>` | abrir/cerrar terminal general|
| `<leader>tf` | abrir terminal flotante|
| `<leader>th` | abrir terminal horizontal| 
| `<Esc><Esc>` | salir de modo terminal|  
| `jk` | salir de modo terminal| 
| `t<C-h>` / `t<C-j>` / `t<C-k>` / `t<C-l>` | navegar entre ventanas desde terminal|
                    
## Plugins importantes
|Comando|Descripcióndocker|
| :--- | :--- |
| `p` / `P` | pegar desde Yanky|  
| `<M-p>` | ciclo adelante en Yanky|  
| `<M-n>` | ciclo atrás en Yanky|  
| `<leader>a` | marcar archivo con Harpoon| 
| `<C-e>` | abrir menú rápido de Harpoon|  
| `<A-1>` … `<A-5>` | saltar a marca Harpoon 1..5|
| `<leader>S` | abrir Spectre (buscar/reemplazar)|
| `<leader>t` | explorador Snacks|  
| `<leader>lg` | abrir Lazygit desde Snacks|  
| `<leader>aa` | abrir dashboard Snacks|  
| `<leader>dk` | abrir LazyDocker|  
                    
## SQL
|Comando|Descripcióndocker|
| :--- | :--- |
| `<leader>rq` | ejecutar SQL con `DB`|  
| `<leader>bj` | ejecutar SQL y mostrar JSON|  
                    
## Neotest
|Comando|Descripcióndocker|
| :--- | :--- |
| `nnr` | correr test cercano| 
| `nnf` | correr tests del archivo actual|
| `nna` | correr toda la suite|
| `nns` | alternar summary de Neotest|
| `nno` | abrir salida del último test|
| `nnp` | alternar panel de salida|
                      
## Config y utilidades
|Comando|Descripcióndocker|
| :--- | :--- |
| `<leader>sv` | recargar config|
| `<leader>cl` | limpiar caché de Neovim|
| `<leader>f` | formatear buffer manualmente con Conform|
| `<leader>sf` | formatear archivo SQL con Conform|
| `<leader>.` | abrir cheatsheet|
| `<leader>ud` | borrar cheatsheet|
| `gf` | buscar siguiente función / palabra de definición|
| `[[` | movimiento rápido en Handlebars|
---                 
