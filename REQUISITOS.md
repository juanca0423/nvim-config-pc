# 🛠️ Entorno de Desarrollo Juanca
![Go](https://img.shields.io/badge/Go-00ADD8?style=for-the-badge&logo=go&logoColor=white)
![Neovim](https://img.shields.io/badge/Neovim-57A143?style=for-the-badge&logo=neovim&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)

# 🚀 Requisitos para Neovim (Windows)

Para que esta configuración funcione de 0 en un equipo nuevo, sigue estos pasos:

## 1. Gestor de Paquetes (Chocolatey)
Abrir PowerShell como Administrador:
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('[https://community.chocolatey.org/install.ps1](https://community.chocolatey.org/install.ps1)'))
```
## 2. Herramientas Base (Lenguajes y Compiladores)
```PowerShell
choco install -y git neovim nodejs-lts python3 go rust visualstudio2022-workload-vctools make ripgrep fd
```
Nota: visualstudio2022-workload-vctools es necesario para compilar Treesitter y jsregexp.

## 3. Ruby (Necesario para algunos plugins)
```PowerShell
choco install -y ruby
```

# Después de instalar Ruby, corre:
```PowerShell
gem install neovim
```
## 4. Herramientas Contables/SQL

```PowerShell
choco install -y postgresql17 # O la versión que uses
```

# Configurar usuario 'juanca' y DB 'eeff'
## 5. Variables de Entorno
No olvides configurar tu contraseña antes de abrir Neovim:

```PowerShell
[System.Environment]::SetEnvironmentVariable('DB_PASS_EEFF', 'TU_CLAVE', 'User')
```
## 6. Fuentes (Nerd Fonts)
Instala 'JetBrainsMono Nerd Font' para ver los iconos correctamente.

## 7. Variables de Entorno para PostgreSQL
Para no dejar tu contraseña en el código, usaremos variables de entorno del sistema (Windows).

Primero, configura la variable en Windows (PowerShell):

```PowerShell
[System.Environment]::SetEnvironmentVariable('DB_PASS_EEFF', 'tu_password_real', 'User')
```

## 8. Cómo ejecutar el Script de Instalación
En Windows, por seguridad, la ejecución de scripts está restringida por defecto. Para correr tu install_everything.ps1, el comando que debes usar en una terminal de PowerShell como Administrador es:

```PowerShell
Set-ExecutionPolicy Bypass -Scope Process -Force; .\install_everything.ps1
```
Set-ExecutionPolicy Bypass: Permite que el script se ejecute omitiendo las restricciones de firma digital solo por esta vez.

.\: Es vital para indicarle a PowerShell que el archivo está en la carpeta actual.

2. Atajo de teclado para Tests (Neotest + Go)
Ya que usas neotest-golang y gotestsum para tu proyecto contable EEFF, este atajo te permitirá validar tus cálculos (liquidez, rotación, etc.) sin salir de Neovim.

Agrega esto a tu archivo de keymaps.lua o dentro de la configuración de Neotest:

Reinicia Neovim después de hacer esto para que cargue la nueva variable.

Luego, en tu config de sqls (dentro de LSP):

```Lua
-- En la sección de settings de sqls
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

---

## 🏁 Primer Inicio de Neovim
Una vez instalado todo el software base del script `.ps1`, abre Neovim y ejecuta:

1. **Instalar Plugins:**
   `:Lazy sync`

2. **Instalar Inteligencia (LSP/Formatters):**
   `:MasonInstall gopls gofumpt goimports golines sqls stylua lua-language-server tailwindcss-language-server typescript-language-server eslint-lsp prettierd debugpy delve`

3. **Instalar Resaltado (Treesitter):**
   `:TSInstall go gomod gowork gotmpl sql lua python javascript typescript html css markdown markdown_inline json`

4. **Compilar JSRegexp (Para Snippets):**

```PowerShell
cd $env:LOCALAPPDATA\nvim-data\lazy\LuaSnip
make install_jsregexp
```

---

## 🛠️ Mantenimiento del Entorno

### 1. Actualizar Plugins y Herramientas
Ejecuta estos comandos semanalmente:
- **Plugins:** `:Lazy update`
- **LSPs/Formatters:** `:MasonUpdate` (luego presiona `U` para actualizar todo)
- **Treesitter:** `:TSUpdate`

### 2. Limpieza de Archivos Temporales
Si Neovim se pone lento o los plugins se comportan raro:
1. Abre `:Lazy` y presiona `X` para limpiar plugins no utilizados.
2. Si persiste, borra la caché de Shada (historial de cursor y registros):
   `Remove-Item $env:LOCALAPPDATA\nvim-data\shada\* -Force`

### 3. Verificación de Salud
Si algo no funciona (ej. los tests de Go o la conexión a Postgres):
- Ejecuta `:checkhealth`
- Revisa especialmente las secciones de `vim.lsp`, `treesitter` y `provider`.

## 🐳 Gestión de Docker (Entorno de Contenedores)

### 1. Verificación de Salud (Health Check)
Antes de empezar a programar, verifica que el motor de Docker esté respondiendo:
```powershell
# Verificar versión y estado del servicio
docker version
docker info | Select-String "Running"
```

### 2. Comandos Esenciales para Desarrollo
Levantar Entorno (DB + App): `docker-compose up -d`

Ver Logs en Tiempo Real: `docker-compose logs -f`

Limpiar Todo (Volúmenes incluidos): `docker-compose down -v`

### 3. Troubleshooting de Contenedores
Si los tests fallan en Neovim pero pasan local, revisa si el contenedor tiene acceso a la red:

```PowerShell
docker inspect -f '{{.State.Status}}' nombre_del_contenedor
```


---

### 1. Mantenimiento Diario: El "Warm-up" del Dev

Para que tu mañana sea fluida, puedes crear un alias en tu perfil de PowerShell (que ya sé que usas en Windows 11) para automatizar el mantenimiento:

#### 1. Abre tu perfil: `notepad $PROFILE`
#### 2. Pega esto:

```powershell
function Dev-Start {
    Write-Host "🚀 Iniciando entorno Juanca..." -ForegroundColor Cyan
    # 1. Checar actualizaciones de Go
    go version
    # 2. Iniciar Docker si no está corriendo (opcional)
    # Start-Process "C:\Program Files\Docker\Docker\Docker Desktop.exe"
    # 3. Limpiar temporales de Neovim
    Remove-Item $env:LOCALAPPDATA\nvim-data\shada\* -Force
    Write-Host "✅ Listo para codear." -ForegroundColor Green
    nvim
}
```
Ahora, solo con escribir Dev-Start en tu terminal, se limpia todo y se abre tu Neovim con el Dashboard de Alpha listo.

---

## Checklist Final 
He notado un par de detalles que podrías pulir en tu archivo para que sea a prueba de errores:

* PostgreSQL 18: En tu texto mencionas la versión 17, pero en tu resumen de actividad ya migraste a la 18. Te sugiero actualizar el comando a choco install -y postgresql18 para evitar conflictos de versiones con tus bases de datos actuales.

* Path de Go: Mason a veces se confunde si las herramientas de Go no están en el Path de usuario. Asegúrate de que `C:\Users\Usuario\go\bin` esté en tus variables de entorno (el script .ps1 ayuda con esto).

---

## 🛠️ FAQ & Solución de Problemas (Troubleshooting)

### 1. 🐘 PostgreSQL 18: "Error de Autenticación o Conexión"
Si al ejecutar `db-shell` o intentar conectar tu app de Go (Fiber) recibes un error de `password authentication failed` o `connection refused`:

* **Causa:** El contenedor de Docker se creó antes de que los volúmenes se limpiaran, o el puerto 5432 está ocupado por una instalación local de Postgres.
* **Solución:**
   * 1.  Detén todo: `docker-compose down`.
   * 2.  Limpia volúmenes antiguos: `docker-compose down -v` (⚠️ esto borra los datos de la DB).
   * 3.  Asegúrate de que no haya un servicio de Postgres corriendo en Windows: 
        `Get-Service postgresql* | Stop-Service`
   * 4.  Vuelve a levantar: `d-up`.

### 2. 📜 PowerShell: "El script no se puede cargar porque la ejecución está deshabilitada"
Si al intentar usar `sync` o abrir la terminal ves un mensaje rojo sobre la **Execution Policy**:

* **Solución Rápida:** Abre PowerShell como Administrador y ejecuta:
    ```powershell
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    ```
* **Nota:** Esto permite que tus scripts locales (como tu perfil y el script de instalación) corran sin problemas.

### 3. ⌨️ Neovim: "Iconos extraños o rectángulos ($\square$)"
Si los iconos de `backups_config` o de la línea de estado no se ven:

* **Causa:** No tienes seleccionada la **Nerd Font** en la Terminal de Windows.
* **Solución:**
    * 1.  Presiona `Ctrl + ,` en la Terminal.
    * 2.  Ve a **Perfiles > PowerShell > Apariencia**.
    * 3.  En **Fuente**, asegúrate de elegir `JetBrainsMono NF` o `CaskaydiaCove NF`.

### 4. 🐹 Go: "No se encuentra el módulo o error en `go.sum`"
Si al crear un `nuevo-repo` los paquetes no se descargan bien:

* **Solución:** Ejecuta manualmente dentro de la carpeta del proyecto:
    ```powershell
    go clean -modcache
    go mod tidy
    ```

---

### 🚀 Un toque extra para tu `REQUISITOS.md`

He diseñado este pequeño diagrama para que veas cómo interactúan ahora todas las piezas que hemos configurado: tu Terminal, tus Scripts de PowerShell, Neovim y los Contenedores.

