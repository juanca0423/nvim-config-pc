# 💻 Neovim PC - Ultimate Cheat Sheet (v0.11)

### 🚀 Navegación y Ventanas
| Atajo | Acción | Contexto |
| :--- | :--- | :--- |
| `<C-h/j/k/l>` | Moverse entre ventanas | Navegación |
| `-` | **Abrir Oil** (Explorador de texto) | Archivos |
| `Ctrl + n`| Abrir/Cerrar Nvim-Tree | Explorador |
| `Tab / S-Tab`| Siguiente / Anterior pestaña | Buffers |
| `<leader>q` | Cerrar pestaña actual | General |

### 🔍 Buscadores y Reemplazo
| Atajo | Acción | Plugin |
| :--- | :--- | :--- |
| `<leader>ff` | Buscar archivos por nombre | Telescope |
| `<leader>fg` | Buscar palabras (Live Grep) | Telescope |
| `<leader>S` | **Buscar y Reemplazar Global** | Spectre |
| `s` | **Saltar a cualquier letra** | Flash |
| `S` | Selección inteligente | Flash |

### 🧠 Inteligencia de Código (LSP)
| Atajo | Acción | Acción |
| :--- | :--- | :--- |
| `gd` | Ir a la definición | `K` | Ver documentación |
| `gr` | Ver referencias | `<leader>rn` | Renombrar (Todo el proyecto) |
| `]d / [d` | Sig / Ant Error | `<leader>ca` | Code Action (Fix) |
| `<leader>xx` | **Trouble:** Ver lista de errores | `<leader>xd` | Errores del archivo |

### 🎣 Harpoon (Tus Favoritos)
| Atajo | Acción |
| :--- | :--- |
| `<leader>a` | Marcar archivo actual |
| `<C-e>` | Ver menú de marcas |
| `Alt + 1..5` | **Salto instantáneo** a marca 1..5 |

### 🐞 Debugging & Testing
| Atajo | Acción | Plugin |
| :--- | :--- | :--- |
| `<leader>db` | Poner Breakpoint | DAP |
| `<leader>dc` | Continuar / Iniciar | DAP |
| `<leader>du` | Toggle Interfaz Debug | DAP UI |
| `<leader>tn` | **Ejecutar Test cercano** | Vim-Test |
| `<leader>tf` | Ejecutar Test del archivo | Vim-Test |

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
| `<leader>.` | **Ver esta Guía** |
| `gg` | Lazygit (Terminal) |
| `<leader>lg`| Ver Logs de Docker (Go App) |
