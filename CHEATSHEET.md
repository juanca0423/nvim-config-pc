# 💻 Neovim PC - Ultimate Cheat Sheet (Sincronizada)

### 🚀 Navegación y Buffers
| Atajo | Acción | Contexto |
| :--- | :--- | :--- |
| `<C-t>` | 📂 Abrir/Cerrar Explorador | Nvim-Tree |
| `Tab / S-Tab` | ➡️ Siguiente / Anterior pestaña | Bufferline |
| `<leader>ba` | 🧹 Cerrar los demás buffers | Limpieza |
| `<leader>q` | ❌ Cerrar buffer actual | General |
| `<leader>aa` | 🏠 Volver al Inicio | Alpha Dashboard |

### ⚡ Movimiento Maestro (Flash.nvim)
| Atajo | Acción | Plugin |
| :--- | :--- | :--- |
| `s` | 🎯 Saltar a cualquier letra | Flash |
| `S` | 🌳 Selección inteligente (Árbol) | Flash |
| `gf` | 🏃 Saltar a la siguiente Función | Custom Map |
| `gF` | 🔙 Saltar a la Función anterior | Custom Map |

### 📜 Desarrollo Go (Gopls & Tools)
| Atajo / CMD | Acción | Contexto |
| :--- | :--- | :--- |
| `]h / [h` | ⏭️ Siguiente / Anterior Cambio | Git |
| `<leader>hp` | 👁️ Previsualizar cambio Git | Gitsigns |
| `:GoClean` | 🧹 Borrar caché y tests de Go | Utilidad |
| `:GoFix` | 🛠️ Formatear y ver Errores | Utilidad |
| `<leader>gt` | 🐹 Debugger para Tests | DAP Go |
| `<leader>hb` | 🕰️ Ver quién escribió la línea | Git Blame |
| `<leader>rr' | 🚀 Ejecutar Proyecto (go run .) | Go / Backend|
| `<leader>tf` | 🖥️ Abrir Terminal Flotante | Terminal|
| `<leader>th` | 📏 Abrir Terminal Horizontal |Terminal|

### 🚀 Jerarquía de Teclas Rápidas (Flechas)
| Combinación | Acción | Categoría |
| :--- | :--- | :--- |
| **`Ctrl + ⬆️/⬇️/⬅️/➡️`** | 🪟 Moverse entre ventanas | Navegación |
| **`Alt + ⬆️/⬇️/⬅️/➡️`** | 📏 Cambiar tamaño (Resize) | Layout |
| **`Shift + ⬆️/⬇️`** | 👥 Añadir cursor (Arriba/Abajo) | Multi-Cursor |

### 🔍 Edición con Multi-Cursores (VVM)
| Atajo | Acción | Plugin |
| :--- | :--- | :--- |
| `Ctrl + n` | 🔍 Seleccionar siguiente palabra igual | Visual-Multi |
| `Ctrl + a` | 📑 Seleccionar TODAS las ocurrencias | Visual-Multi |
| `q` | ⏭️ Saltar (skip) la ocurrencia actual | Visual-Multi |
| `Esc Esc` | 🚪 Salir totalmente al modo normal | Visual-Multi |

### 🪟 Gestión de Ventanas (Layout)
| Atajo | Acción | Teclas |
| :--- | :--- | :--- |
| `<C-Flechas>` | 🔀 Moverse entre ventanas | Izq, Der, Up, Down |
| `<Alt-Flechas>`| 📏 Redimensionar ventanas | + / - Tamaño |
| `<leader>zm` | 🔍 Maximizar Ventana (Zen) | Toggle |
| `<leader>=` | ⚖️ Igualar tamaños | Reset |

### 🔍 Buscadores (Telescope)
| Atajo | Acción | Plugin |
| :--- | :--- | :--- |
| `<leader>ff` | 🔎 Buscar archivos por nombre | Telescope |
| `<leader>fg` | 📝 Buscar texto (Live Grep) | Telescope |
| `<leader>td` | 🏷️ Buscar TODOs/Notas | Todo-Comments |
| `<leader>h`  | 📋 Historial de copiado (Yank) | Telescope |
| `<leader>fn` | ⚙️ Configuración de Neovim | Acceso rápido |
| `<leader>f`  | 🛠️ Formatear archivo (Manual) | Conform |
| `p / P` | 📋 Pegar con historial | Yanky |
| `s` | 🎯 Saltar a cualquier letra | Flash |


### 🐞 Debugging (DAP) & Go
| Atajo | Acción | Plugin |
| :--- | :--- | :--- |
| `<leader>db` | 🛑 Poner Breakpoint | DAP |
| `<leader>dc` | ▶️ Iniciar / Continuar | DAP |
| `<leader>dn` | ⏭️ Siguiente línea (Step Over) | DAP |
| `<leader>du` | 🖥️ Ver Interfaz de Debug | DAP UI |
| `<leader>gt` | 🐹 Debugger para Test en Go | DAP Go |
| `<leader>xx` | 🚩 Trouble: Ver lista de errores | Trouble |
| `K` | 📖 Ver documentación (Hover) | LSP |
| `<leader>tn` | Ejecutar Test cercano | Vim-Test |
| `<leader>tf` | Ejecutar Test del archivo | Vim-Test |
|`<leader>e`|Ver Error flotante||
|`<leader>v`|Toggle Texto Virtual||
|`<leader>v`| Toggle Texto Virtual (Errores) | Diagnósticos |
|`<leader>xx`| Trouble: Ver lista de errores ||
|`<leader>xd`| Errores del archivo ||

### 🐳 Docker & Terminal
| Atajo | Acción | Contexto |
| :--- | :--- | :--- |
| `<leader>dps` | 📋 Ver Estado (PS) | Flotante |
| `<leader>dl`  | 📄 Ver Logs App Go | Flotante |
| `<leader>dup` | 🔼 Compose UP | Flotante |
| `<leader>ddo` | 🔽 Compose DOWN | Flotante |
| `<leader>te`  | 💻 Abrir Terminal Split | Terminal |
| `<Esc><Esc>`  | 🔓 Salir Modo Terminal | Terminal |

### 🗄️ Base de Datos (SQL)
| Atajo | Acción | Contexto |
| :--- | :--- | :--- |
| `<leader>rq` | ⚡ Ejecutar Query actual | DB / SQL |
| `<leader>bj` | 📄 Resultado SQL a JSON | Formato |
| `<leader>bd` | 🗄️ Abrir Interfaz de DB | DBUI |
|`<leader>sf`|Formatear SQL (SQL-Format)|SQL / DB|

### 🎣 Harpoon & Pro
| Atajo | Acción | Plugin |
| :--- | :--- | :--- |
| `<leader>a` | 📍 Marcar archivo actual | Harpoon |
| `<C-e>` | 📋 Ver menú de marcas | Harpoon |
| `p / P` | 📋 Pegar con historial | Yanky |
| `Alt + 1..5` |Salto instantáneo a marca 1..5 |
| `za / zk` | 📂 Plegar código | UFO |

### 📝 Edición Pro
| Atajo | Acción | Plugin |
| :--- | :--- | :--- |
| `p / P` | Pegar con historial | Yanky |
| `Alt + n / p`| Ciclar historial de copiado | Yanky |
| `<leader>nf` | Documentar Función | Neogen |
| `<leader>nc` | Documentar Clase/Struct | Neogen |


### 🌐 Administración
| Atajo | Acción |
| :--- | :--- |
| `<leader>w`  | 💾 Guardar archivo |
| `<leader>sv` | 🔄 Recargar configuración |
| `<leader>.`  | 📖 Ver esta Guía |
| `<leader>cl` | 🧼 Limpiar Caché Neovim |
|`:GoClean`|🧹 Borrar caché de compilación y tests de Go|
|`:GoFix`|🛠️ Formatear y cargar errores en Quickfix|
| `F11` | Pantalla Completa |
| `Win + ↑` | Maximizar Ventana |
| `:Lazy` | 📦 Gestionar Plugins |
| `:Mason` | 🛠️ Gestionar LSPs/Binarios |

---
*Nota: Si cambias un atajo, usa `<leader>cl` y reinicia para actualizar esta guía.*
