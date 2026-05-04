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

## Dependencias Externas (Windows - Winget)
Para que Snacks y el entorno funcionen al 100%:
- `winget install jesseduffield.lazygit` (Gestión de Git)
- `winget install ImageMagick.ImageMagick` (Previsualización de imágenes)
- `winget install sharkdp.fd` (Buscador rápido de archivos)
- `winget install BurntSushi.ripgrep` (Buscador de texto)

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
   ```Nvim 
   :Lazy sync
   ```

2. **Instalar Inteligencia (LSP/Formatters):**
   ```Nvim
   :MasonInstall gopls gofumpt goimports golines sqls stylua lua-language-server tailwindcss-language-server typescript-language-server eslint-lsp prettierd debugpy delve
   ```

3. **Instalar Resaltado (Treesitter):**
   ```Nvim
   :TSInstall go gomod gowork gotmpl sql lua python javascript typescript html css markdown markdown_inline json regex
   ```

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

## 🛠️ Troubleshooting (Solución de Problemas)

### 🐘 Mi base de datos Postgres no arranca
Si el contenedor de Docker dice que los archivos son incompatibles (v17 vs v18):
1. Ejecuta: `docker-compose down`
2. Borra la carpeta de volumen: `Remove-Item -Recurse -Force ./postgres_data`
3. Reinicia: `d-up` (esto recreará la DB limpia).

### 🚀 El perfil carga lento (> 2s)
1. Revisa si el cronómetro subió.
2. Limpia el caché de Oh My Posh: `Remove-Item $env:TEMP\oh-my-posh-cache-*.ps1`
3. Recarga con `r`.
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

### 🐹 Go Quick-Fix
- Limpiar caché de módulos: `go clean -modcache`
- Actualizar dependencias: `go mod tidy`
- Ver por qué falla un import: `go mod verify`

---

# Usar PowerShell 7 (pwsh) como terminal definitiva 

¡Perfecto! Usar PowerShell 7 (pwsh) es la mejor opción. Aquí tienes cómo hacerlo tu predeterminado:
* Opción 1: Cambiar en Windows Terminal (Recomendado)
  - Si usas Windows Terminal (la app moderna de terminal):
  - Abre Windows Terminal
  - Presiona `Ctrl +` , (o clic en ▼ → Configuración)
  - En "Perfil predeterminado" selecciona PowerShell (el icono negro, no el azul de Windows PowerShell)
  - Guarda (`Ctrl + S`)
   `https://learn.microsoft.com/en-us/windows/terminal/images/settings-default-profile.png`
* Opción 2: Crear acceso directo personalizado
  - Crea un archivo pwsh.lnk en tu escritorio con este destino:
   `"C:\Program Files\PowerShell\7\pwsh.exe" -NoExit -Command "cd ~"`
* Opción 3: Reemplazar `Win + X` menú (Avanzado)

  Si quieres que `Win + X → I` abra pwsh en lugar de Windows PowerShell:
  Powershell
  Ejecutar como Administrador en Windows 
  ```PowerShell
  Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DontUsePowerShellOnWinX" -Value 0
  ```
  Luego reinicia el explorador:
  ```Powershell
  Stop-Process -Name explorer
  ```
  Verificación Rápida
  Una vez configurado, abre una nueva terminal y verifica:
  ```Powershell
  $PSVersionTable.PSVersion
  ```
  Debe mostrar 7.x.x, no 5.1.
  >[!TIP]Nota: La forma más infalible en Windows 11 es ir a 
  >Configuración > Privacidad y seguridad > Para programadores y activar la opción de Terminal como aplicación predeterminada.

Bonus: Tu perfil funcionará al 100%
Con pwsh tendrás:
✅ Terminal-Icons sin errores
✅ Mejor rendimiento
✅ Todas tus funciones (nuevo-repo, db-shell, etc.)
✅ Oh My Posh optimizado

---

## Problemas con OH MY POSH 

Problema Tu Oh My Posh se está cargando en pwsh, pero con un tema diferente (el default en lugar de tu Catppuccin Mocha). Además, el prompt muestra  Usuario  en lugar de tu  Usuario@juan-carlos.
El problema está en tu lógica de caché de Oh My Posh. En tu $PROFILE tienes esto:
```Powershell
# --- OH MY POSH CACHE ---
$poshCache = "$env:TEMP\oh-my-posh-cache.ps1"
if (-not (Test-Path $poshCache)) {
    oh-my-posh init pwsh --config "$HOME\Documents\PoshThemes\catppuccin_mocha.omp.json" > $poshCache
}
```
El problema: El archivo de caché ya existe pero fue generado para Windows PowerShell (con powershell en lugar de pwsh), o el tema no se está aplicando correctamente.
Solución Rápida: Limpiar Caché y Regenerar
Ejecuta estos comandos en tu pwsh actual:
```Powershell
# 1. Eliminar el caché viejo
Remove-Item "$env:TEMP\oh-my-posh-cache.ps1" -ErrorAction SilentlyContinue
# 2. Recargar el perfil
. $PROFILE
```
Esto regenerará el caché con la configuración correcta para pwsh.
Solución Definitiva: Mejorar tu configuración
Para evitar este problema en el futuro, modifica tu $PROFILE. Reemplaza esta sección:
```owershell
# --- OH MY POSH CACHE ---
$poshCache = "$env:TEMP\oh-my-posh-cache.ps1"
if (-not (Test-Path $poshCache)) {
    oh-my-posh init pwsh --config "$HOME\Documents\PoshThemes\catppuccin_mocha.omp.json" > $poshCache
}
. $poshCache
```
Por esta versión más robusta:
```Powershell
# --- OH MY POSH ---
$poshConfig = "$HOME\Documents\PoshThemes\catppuccin_mocha.omp.json"
$poshCache = "$env:TEMP\oh-my-posh-cache-$($PSVersionTable.PSVersion.Major).ps1"

# Regenerar si no existe o si cambió la configuración
if (-not (Test-Path $poshCache) -or (Get-Item $poshConfig).LastWriteTime -gt (Get-Item $poshCache).LastWriteTime) {
    oh-my-posh init pwsh --config $poshConfig --no-status > $poshCache
}
. $poshCache
```
Cambios clave:
Caché separado por versión de PowerShell (-PSVersionTable.PSVersion.Major)
Detecta cambios en el archivo de tema y regenera automáticamente
Si sigue sin funcionar...
Verifica que el tema existe:
```Powershell
Test-Path "$HOME\Documents\PoshThemes\catppuccin_mocha.omp.json"
```
Si no existe, descárgalo:
```Powershell
# Crear directorio si no existe
New-Item -ItemType Directory -Path "$HOME\Documents\PoshThemes" -Force

# Descargar tema Catppuccin Mocha
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/catppuccin_mocha.omp.json" -OutFile "$HOME\Documents\PoshThemes\catppuccin_mocha.omp.json"
```

Luego recarga:
```Powershell
. $PROFILE
```

---
|White|Text / Lavender|Fechas y texto secundario.|


## 🎨 Paleta de Colores (Catppuccin Mocha)

| Elemento | Color PWSH | Tono Catppuccin | Hex (Ref) |
| :--- | :--- | :--- | :--- |
| Logo / Títulos | `Magenta` | Pink | `#f5c2e7` |
| Rutas / Links | `Cyan` | Sky | `#89dceb` |
| Advertencias | `Yellow` | Peach | `#fab387` |
| Sincronización | `Green` | Green | `#a6e3a1` |
| Líneas / Info | `DarkGray` | Surface1 | `#585b70` |
| Texto General | `White` | Text (Mocha) | `#cdd6f4` |

---

## 🚀 Optimización de Rendimiento (Lazy Loading)

Para mantener el inicio por debajo de los **200ms**, aplicamos carga perezosa en los módulos pesados:

1. **Terminal-Icons:** Solo se carga al ejecutar `ll` por primera vez.
2. **Oh My Posh:** Se usa un sistema de caché basado en la versión de la terminal y la última modificación del tema.
---
