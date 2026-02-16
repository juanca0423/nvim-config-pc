
# 💻 Neovim PC - Ultimate Cheat Sheet (v0.11)


### 🚀 Navegación y Ventanas
| Atajo | Acción | Contexto |
| :--- | :--- | :--- |
| `-` | Abrir Oil (Explorador de texto) | Archivos |
| `Ctrl + t`| Abrir/Cerrar Nvim-Tree | Explorador |
| `Tab / S-Tab`| Siguiente / Anterior pestaña | Buffers |
| `<leader>q` | Cerrar pestaña actual | General |
|`<leader>ba`|Cerrar los demás buffers|General|


### 🖥️ Control de Ventana (Windows)
| Atajo | Acción |
| :--- | :--- |
| `F11` | Pantalla Completa |
| `Win + ↑` | Maximizar Ventana |


### 🪟 Navegación de Ventanas
|Atajo|Acción|Teclas Vim|
| :--- | :--- | :--- |
|`<C-◀>`|Ventana Izquierda|h|
|`<C-▼>`|Ventana Abajo|j|
|`<C-▲>`|Ventana Arriba|k|
|`<C-▶>`|Ventana Derecha|l|


### 📏 Redimensionar Ventanas
| Atajo | Acción | Icono |
| :--- | :--- | :--- |
| `<A-Up>` | Más alto | ▲ |
| `<A-Down>` | Menos alto | ▼ |
| `<A-Left>` | Menos ancho | ◀️ |
| `<A-Right>` | Más ancho | ▶️ |
|`<leader>m`|Maximizar ventana|dentro terminal|
|`<leader> =`|Igualar ventanas|dentro terminal|


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


