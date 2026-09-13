# 🖥️ Configuración de Neovim - Entorno de Desarrollo Juanca

[![Go](https://img.shields.io/badge/Go-00ADD8?style=for-the-badge&logo=go&logoColor=white)](https://golang.org/)
[![Neovim](https://img.shields.io/badge/Neovim-57A143?style=for-the-badge&logo=neovim&logoColor=white)](https://neovim.io/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)

## 📋 Descripción

Esta es una configuración personalizada de Neovim diseñada para un entorno de desarrollo full-stack con enfoque en:
- Desarrollo backend en Go
- Gestión de bases de datos PostgreSQL
- Containerización con Docker
- Workflow optimizado con Git Worktrees
- Integración completa de LSP, debugging y testing

## 🚀 Características Principales

- **Líder personalizado**: `,` (coma) como tecla líder
- **Explorador de archivos**: Oil.nvim integrado
- **Autocompletado avanzado**: nvim-cmp con fuentes LSP, snippets, buffer y path
- **Diagnósticos en tiempo real**: nvim-lspconfig + nvim-lint + conform.nvim
- **Debugging completo**: nvim-dap con adapters para Go, Python y más
- **Gestión de sesiones**: Persistencia de trabajo con sesiones
- **Terminal integrada**: ToggleTerm con múltiples split
- **Navegación rápida**: Telescope para búsqueda difusa
- **Snippets inteligentes**: LuaSnip con friendly-snippets
- **Formateo automático**: Conform.nvim con soporte para múltiples lenguajes
- **Gestión de plugins**: Lazy.nvim para carga perezosa y actualizaciones simples
- **Tema visual**: Catppuccin Mocha para una experiencia agradable
- **Iconos**: Nerd Fonts y nvim-web-devicons
- **Git integration**: Gitsigns.nvim y LazyGit integrado
- **Documentación**: Generación automática de cheatsheet
- **Worktrees**: Sistema de worktrees de Git para desarrollo paralelo

## 🛠️ Tecnologías Incluidas

### Lenguajes y Runtimes
- Go (con gopls, gofumpt, goimports, golines, delve)
- Lua (con lua-language-server, stylua)
- Python (con pylsp, black, debugpy)
- JavaScript/TypeScript (con typescript-language-server, eslint-lsp, prettierd)
- SQL (con sqls)
- Tailwind CSS (con tailwindcss-language-server)

### Herramientas de Desarrollo
- **LSP**: Configuración completa para múltiples lenguajes
- **Debugging**: DAP UI integrado con adaptadores específicos
- **Testing**: Neotest con adapters para Go y más
- **Formateo**: Conform.nvim con múltiples formatters
- **Linting**: Nvim-lint con linters específicos por lenguaje
- **Snippets**: LuaSnip con friendly-snippets
- **Explorador**: Oil.nvim como reemplazo moderno de netrw
- **Estado**: Lualine.nvim con información contextual
- **Buffers**: Bufferline.nvim para gestión mejorada
- **Búsqueda**: Telescope.nvim con preview y filtros avanzados
- **Árbol de sintaxis**: Nvim-treesitter con contexto y autotag
- **Markdown**: Render-markdown.nvim para preview mejorado
- **Base de datos**: Vim-dadbod con completion y UI
- **Docker**: LazyDocker integrado
- **SQL**: Snippets y funciones especiales para consultas

## 📦 Requisitos Previos

Antes de instalar esta configuración, asegúrate de tener instalado:

### En Windows (usando Chocolatey)
```powershell
# Gestor de paquetes
Set-ExecutionPolicy Bypass -Scope Process -Force; 
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; 
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Herramientas base
choco install -y git neovim nodejs-lts python3 go rust visualstudio2022-workload-vctools make ripgrep fd ruby

# Después de Ruby:
gem install neovim

# Base de datos
choco install -y postgresql18

# Variables de entorno para PostgreSQL
[System.Environment]::SetEnvironmentVariable('DB_PASS_EEFF', 'TU_CLAVE_AQUI', 'User')

# Fuentes
# Instala 'JetBrainsMono Nerd Font' o similar para ver los iconos correctamente

# Dependencias externas (winget)
winget install jesseduffield.lazygit
winget install ImageMagick.ImageMagick
winget install sharkdp.fd
winget install BurntSushi.ripgrep
```

## 🔧 Instalación

1. **Clona este repositorio** en tu directorio de configuración de Neovim:
   ```powershell
   git clone https://github.com/tu-usuario/neovim-config.git $env:LOCALAPPDATA\nvim
   ```

2. **Inicia Neovim** y deja que Lazy.nvim instale los plugins automáticamente:
   ```powershell
   nvim
   ```

3. **En Neovim**, ejecuta:
   ```vim
   :Lazy sync
   ```

4. **Instala los LSPs y herramientas**:
   ```vim
   :MasonInstall gopls gofumpt goimports golines sqls stylua lua-language-server tailwindcss-language-server typescript-language-server eslint-lsp prettierd debugpy delve
   ```

5. **Instala los parsers de Treesitter**:
   ```vim
   :TSInstall go gomod gowork gotmpl sql lua python javascript typescript html css markdown markdown_inline json regex
   ```

6. **Compila JSRegexp** (requerido para algunos snippets):
   ```powershell
   cd $env:LOCALAPPDATA\nvim-data\lazy\LuaSnip
   make install_jsregexp
   ```

## 🎯 Uso Básico

### Atajos de Teclado Importantes

| Atajo | Acción |
|-------|--------|
| `,w` | Guardar archivo |
| `,q` | Cerrar buffer actual |
| `,ba` | Cerrar todos los demás buffers |
| `,cp` | Copiar ruta completa del archivo |
| `,wb` | Abrir http://localhost:8080 |
| `-` | Abrir Oil (explorador de archivos) |
| `gd` | Ir a definición |
| `gi` | Ir a implementación |
| `gr` | Ver referencias |
| `K` | Mostrar documentación LSP |
| `,d` | Abrir ventana flotante de diagnóstico |
| `,e` | Mostrar error flotante |
| `]d` | Ir al siguiente diagnóstico |
| `[d` | Ir al diagnóstico anterior |
| `,v` | Alternar texto virtual de diagnósticos |
| `,rn` | Renombrar símbolo |
| `,ca` | Acciones de código |
| `<leader>ff` | Buscar archivos |
| `<leader>fg` | Buscar texto con live grep |
| `<leader>fb` | Listar buffers |
| `<leader>fr` | Abrir archivos recientes |
| `<leader>h` | Historial de yank |
| `<leader>td` | Buscar TODOs |
| `<leader>fs` | Símbolos del documento |
| `<leader>fS` | Símbolos del workspace |
| `<leader>fp` | Proyectos recientes |
| `<leader>hd` | Buscar ayuda/documentación |
| `<leader>sv` | Recargar configuración |
| `<leader>cl` | Limpiar caché de Neovim |
| `<leader>f` | Formatear buffer manualmente |
| `<leader>sf` | Formatear archivo SQL |
| `<leader>.` | Abrir la guía de cheatsheet |
| `<leader>ud` | Borrar cheatsheet |
| `gf` | Buscar siguiente función/definición |
| `[[` | Movimiento rápido en Handlebars |
| `]]` | Movimiento rápido en Handlebars |

### Ventanas y Layout

| Atajo | Acción |
|-------|--------|
| `<C-Left>` | Mover cursor a ventana izquierda |
| `<C-Down>` | Mover cursor a ventana inferior |
| `<C-Up>` | Mover cursor a ventana superior |
| `<C-Right>` | Mover cursor a ventana derecha |
| `<M-Right>` | Agrandar ventana horizontal (+5) |
| `<M-Left>` | Reducir ventana horizontal (-5) |
| `<M-Down>` | Agrandar ventana vertical (+5) |
| `<M-Up>` | Reducir ventana vertical (-5) |
| `,m` | Maximizar la ventana actual |
| `,=` | Equalizar tamaño de ventanas |
| `,zm` | Activar/desactivar modo Zen Maximize |

### LSP y Programación

| Atajo | Acción |
|-------|--------|
| `gi` | Ir a implementación |
| `gd` | Ir a definición |
| `gr` | Ver referencias |
| `K` | Mostrar hover de LSP |
| `<leader>d` | Abrir ventana flotante de diagnóstico |
| `<leader>e` | Mostrar error flotante |
| `]d` | Ir al siguiente diagnóstico |
| `[d` | Ir al diagnóstico anterior |
| `<leader>v` | Alternar texto virtual de diagnósticos |
| `<leader>rn` | Renombrar símbolo |
| `<leader>ca` | Acciones de código |
| `i <C-k>` | Firma de función en modo insert |

### Snippets

| Atajo | Acción |
|-------|--------|
| `i <C-k>` | Expandir o saltar en snippets |
| `i <C-j>` | Saltar hacia atrás en snippets |

### Debugging (DAP)

| Atajo | Acción |
|-------|--------|
| `<leader>db` | Activar/desactivar breakpoint |
| `<leader>dc` | Continuar ejecución |
| `<leader>dn` | Step over (paso siguiente) |
| `<leader>di` | Step into (entrar) |
| `<leader>dr` | Reiniciar DAP |
| `<leader>gt` | Ejecutar test Go con `dap-go` |
| `F5` | Iniciar/continuar debug |
| `F10` | Step over |
| `F11` | Step into |
| `F12` | Step out |
| `<leader>b` | Toggle breakpoint |
| `<leader>B` | Set breakpoint condicional |
| `<leader>du` | Toggle UI de DAP |

### Git / Gitsigns

| Atajo | Acción |
|-------|--------|
| `]h` | Siguiente hunk |
| `[h` | Hunk anterior |
| `<leader>hp` | Previsualizar hunk |
| `<leader>hb` | Blame completo de línea |
| `<leader>hd` | Diff del archivo |

### Terminal y ToggleTerm

| Atajo | Acción |
|-------|--------|
| `<C-\>` | Abrir/cerrar terminal general |
| `<leader>tf` | Abrir terminal flotante |
| `<leader>th` | Abrir terminal horizontal |
| `<Esc><Esc>` | Salir de modo terminal |
| `jk` | Salir de modo terminal |
| `t<C-h>` / `t<C-j>` / `t<C-k>` / `t<C-l>` | Navegar entre ventanas desde terminal |

### Plugins Importantes

| Atajo | Acción |
|-------|--------|
| `p` / `P` | Pegar desde Yanky |
| `<M-p>` | Ciclo adelante en Yanky |
| `<M-n>` | Ciclo atrás en Yanky |
| `<leader>a` | Marcar archivo con Harpoon |
| `<C-e>` | Abrir menú rápido de Harpoon |
| `<A-1>` … `<A-5>` | Saltar a marca Harpoon 1..5 |
| `<leader>S` | Abrir Spectre (buscar/reemplazar) |
| `<leader>t` | Explorador Snacks |
| `<leader>lg` | Abrir Lazygit desde Snacks |
| `<leader>aa` | Abrir dashboard Snacks |
| `<leader>dk` | Abrir LazyDocker |

### SQL

| Atajo | Acción |
|-------|--------|
| `<leader>rq` | Ejecutar SQL con `DB` |
| `<leader>bj` | Ejecutar SQL y mostrar resultado en JSON |

### Neotest

| Atajo | Acción |
|-------|--------|
| `nnr` | Correr test cercano |
| `nnf` | Correr tests del archivo actual |
| `nna` | Correr toda la suite |
| `nns` | Alternar summary de Neotest |
| `nno` | Abrir salida del último test |
| `nnp` | Alternar panel de salida |

### Config y Utilidades

| Atajo | Acción |
|-------|--------|
| `<leader>sv` | Recargar configuración |
| `<leader>cl` | Limpiar caché de Neovim |
| `<leader>f` | Formatear buffer manualmente con Conform |
| `<leader>sf` | Formatear archivo SQL con Conform |
| `<leader>.` | Abrir la guía de cheatsheet si existe |
| `<leader>ud` | Borrar la guía de cheatsheet (`CHEATSHEET.md`) |
| `gf` | Buscar siguiente función / palabra de definición |
| `[[` | Movimiento rápido en Handlebars |

## 🔄 Git Worktrees

Esta configuración incluye un sistema optimizado para trabajar con Git Worktrees, permitiéndote tener múltiples ramas activas simultáneamente sin interferir entre sí.

### Comandos Personalizados

He creado funciones de PowerShell para facilitar el uso de worktrees:

#### Nuevo Worktree
```powershell
gw feature/nueva-funcionalidad
```
Crea una nueva rama y un worktree asociado en la estructura `nombre-del-proyecto.worktrees/nombre-de-la-carpeta`.

#### Eliminar Worktree
```powershell
gwr ../nombre-de-la-carpeta
```
Elimina de forma segura el worktree y libera la rama.

Estos aliases están disponibles si agregas las funciones a tu perfil de PowerShell (ver sección de PowerShell abajo).

## 💻 Configuración de PowerShell

Para aprovechar al máximo esta configuración, se recomienda usar PowerShell 7 (pwsh) como tu terminal predeterminada.

### Funciones Útiles para tu Perfil ($PROFILE)

```powershell
# Función para crear nuevos Git Worktrees
function New-GitWorktree {
    param (
        [Parameter(Mandatory=$true)]
        [string]$BranchName,
        [string]$FolderName
    )

    if (-not (git rev-parse --is-inside-work-tree 2>$null)) {
        Write-Host "❌ Error: ¡No estás dentro de un repositorio de Git!" -ForegroundColor Red
        return
    }

    if (-not $FolderName) {
        $FolderName = $BranchName -replace '.*/', ''
    }

    $RepoRoot = (git rev-parse --show-toplevel).Trim()
    $RepoName = Split-Path $RepoRoot -Leaf
    $WorktreePath = Join-Path (Split-Path $RepoRoot -Parent) "$RepoName.worktrees/$FolderName"

    Write-Host "`n🚀 Inicializando nuevo entorno Git Worktree..." -ForegroundColor Cyan
    Write-Host "📂 Repositorio base:  $RepoName" -ForegroundColor Gray
    Write-Host "🌿 Nueva rama:         $BranchName" -ForegroundColor Lavender
    Write-Host "📍 Destino físico:    $WorktreePath" -ForegroundColor Gray
    Write-Host "--------------------------------------------------" -ForegroundColor DarkGray

    git worktree add $WorktreePath -b $BranchName

    if ($LASTEXITCODE -eq 0) {
        Write-Host "`n✨ ¡Entorno creado con éxito!" -ForegroundColor Green
        Write-Host "👉 Para empezar a trabajar en esta rama, ejecuta:" -ForegroundColor Yellow
        Write-Host "   cd `"$WorktreePath`"" -ForegroundColor White
    } else {
        Write-Host "`n❌ Hubo un error al intentar crear el worktree. Revisa los mensajes de Git arriba." -ForegroundColor Red
    }
}

# Alias corto
Set-Alias -Name gw -Value New-GitWorktree

# Función para remover worktrees
function Remove-GitWorktree {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Path
    )
    git worktree remove $Path
}
Set-Alias -Name gwr -Value Remove-GitWorktree

# Función de arranque rápido para desarrollo
function Dev-Start {
    Write-Host "🚀 Iniciando entorno Juanca..." -ForegroundColor Cyan
    go version
    Remove-Item $env:LOCALAPPDATA\nvim-data\shada\* -Force
    Write-Host "✅ Listo para codear." -ForegroundColor Green
    nvim
}
```

## 🐳 Docker y Base de Datos

Esta configuración incluye atajos específicos para trabajar con Docker y PostgreSQL:

| Atajo | Acción |
|-------|--------|
| `<leader>dps` | Mostrar estado de Docker (`docker ps`) |
| `<leader>ddo` | Ejecutar `docker-compose down` |
| `<leader>dk` | Reiniciar app Go (`docker restart go_web_app`) |
| `<leader>drb` | Reconstruir y levantar Docker (`docker-compose down && docker-compose up --build -d`) |
| `<leader>rq` | Ejecutar SQL con `DB` |
| `<leader>bj` | Ejecutar SQL y mostrar resultado en JSON |

### Variables de Entorno

Para la conexión a la base de datos, configura estas variables en tu sistema:

```powershell
[System.Environment]::SetEnvironmentVariable('DB_PASS_EEFF', 'tu_password_real', 'User')
```

La configuración de SQLs en LSP usa esta variable:
```lua
sqls = {
  connections = {
    {
      driver = "postgresql",
      dataSourceName = string.format(
        "host=127.0.0.1 port=5432 user=juanca password=%s dbname=eeff sslmode=disable", os.getenv("DB_PASS_EEFF") or ""
      ),
    },
  },
}
```

## 📚 Documentación y Cheatsheet

Esta configuración incluye un sistema de generación automática de cheatsheet basado en tus atajos personalizados.

- **Abrir cheatsheet**: `<leader>.`
- **Regenerar cheatsheet**: Edita `CHEATSHEET.md` y guarda los cambios
- **Borrar cheatsheet**: `<leader>ud`

El cheatsheet se genera automáticamente desde tu configuración de keymaps en `lua/mapas.lua`.

## 🛠️ Mantenimiento

### Actualizaciones Regulares

```powershell
# En Neovim:
:Lazy update      # Actualizar plugins
:MasonUpdate      # Actualizar LSPs y herramientas
:TSUpdate         # Actualizar parsers de Treesitter
```

### Limpieza

```powershell
# Limpiar caché de Neovim
Remove-Item $env:LOCALAPPDATA\nvim-data\shada\* -Force

# En Neovim:
:Lazy clean       # Limpiar plugins no utilizados
:checkhealth      # Verificar salud de la instalación
```

## 🔐 Gestión de Secretos (.env)

Para mantener seguros tus datos sensibles como claves de API y credenciales de base de datos, este proyecto incluye soporte para archivos `.env`:

- Archivo `.env.example`: Plantilla con todas las variables de entorno necesarias
- Archivo `.env`: Para tus configuraciones locales (NO se sube a git por estar en `.gitignore`)
- Las variables se cargan automáticamente para herramientas como:
  - CodeCompanion (para conexión a Ollama u otros LLMs)
  - SQLs LSP (para conexión a PostgreSQL)
  - Y cualquier otra herramienta que lea variables de entorno

### Variables Disponibles

```dotenv
# ============================================================
# VARIABLES DE ENTORNO PARA IA Y HERRAMIENTAS
# ============================================================
# Copia este archivo a .env.local y edita con tus claves reales
# NO comitees .env.local a git (está en .gitignore)

# --- OLLAMA (Local LLM - usado por CodeCompanion) ---
# Por defecto Ollama no requiere API key si corre local
# OLLAMA_HOST=http://localhost:11434
# OLLAMA_API_KEY=tu_clave_si_usas_autenticacion

# --- OPENAI / OPENAI-COMPATIBLE ---
# OPENAI_API_KEY=sk-...
# OPENAI_BASE_URL=https://api.openai.com/v1

# --- ANTHROPIC ---
# ANTHROPIC_API_KEY=sk-ant-...

# --- DEEPSEEK ---
# DEEPSEEK_API_KEY=sk-...

# --- GITHUB COPILOT / GITHUB MODELS ---
# GITHUB_TOKEN=ghp_...

# --- GOOGLE GEMINI ---
# GOOGLE_API_KEY=...

# ============================================================
# BASE DE DATOS (PostgreSQL)
# ============================================================
# DB_PASS_EEFF=tu_password_real_aqui
# DB_HOST=127.0.0.1
# DB_PORT=5432
# DB_USER=juanca
# DB_NAME=eeff

# ============================================================
# OTROS SERVICIOS
# ============================================================
# DOCKER_HOST=unix:///var/run/docker.sock
# LAZYGIT_CONFIG_DIR=~/.config/lazygit
```

## 📄 Cheatsheet Dinámico

Esta configuración incluye un sistema inteligente para generar y mantener tu `CHEATSHEET.md` actualizado:

### ¿Cómo funciona?

1. **Generación Automática**: Al iniciar Neovim por primera vez, se genera automáticamente `CHEATSHEET.md` basado en todos tus atajos configurados
2. **Incluye Todo**: Captura atajos de:
   - Tu configuración personal (`mapas.lua`)
   - Todos los plugins instalados (Telescope, DAP, Snacks, Trouble, etc.)
   - Funciones personalizadas de Lua
3. **Actualización Manual**: 
   - Para regenerar: Edita `CHEATSHEET.md` y guarda, o usa `<leader>ud` para borrarlo y se regenerará en el próximo inicio
   - Para abrir: `<leader>.` abre el cheatsheet en una división vertical

### Qué Incluye el Cheatsheet

- Todas las combinaciones de teclas organizadas por categoría
- Atajos de LSP, debugging, terminal, Git, base de datos
- Comandos de plugins como CodeCompanion, Kulala, Harpoon, etc.
- Descripciones claras de qué hace cada atajo
- Formato de tabla fácil de leer y consultar

Este sistema garantiza que tu referencia de atajos esté siempre sincronizada con tu configuración real, sin necesidad de actualizaciones manuales.

## 🤝 Contribuir

Si deseas mejorar esta configuración:

1. Haz un fork del repositorio
2. Crea una rama para tu feature: `git checkout -b feature/mejora-xyz`
3. Haz tus cambios
4. Envía un pull request

Por favor, mantén el estilo de código y los comentarios en español como está establecido en este proyecto.

## 📄 Licencia

Este proyecto está bajo la licencia MIT. Consulta el archivo `LICENSE` para más detalles.

## 🙏 Agradecimientos

- A la comunidad de Neovim por crear un editor tan extensible y potente
- A los autores de todos los plugins utilizados en esta configuración
- A los creadores de los temas y herramientas de productividad integradas
- A todos aquellos que compartieron conocimiento que hizo posible esta configuración

---

¡Disfruta codificando con este entorno optimizado para productividad y enfoque! 🚀