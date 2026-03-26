# Script de instalación Juanca - Versión Optimizada
Write-Host "🚀 Iniciando instalación de herramientas..." -ForegroundColor Cyan

# 0. Configurar permisos de ejecución para esta sesión
Set-ExecutionPolicy Bypass -Scope Process -Force

# 1. Instalar Chocolatey
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "📦 Instalando Chocolatey..."
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    # Refrescar variables de entorno para que reconozca 'choco' de inmediato
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

# 2. Instalación de Herramientas y FUENTES
Write-Host "🛠️ Instalando paquetes y fuentes..."
# Agregamos la fuente y oh-my-posh por si no está
choco install -y neovim git nodejs-lts python3 go rust make ripgrep fd ruby postgresql15 julia jetbrainsmononerdfont oh-my-posh

# 3. REFRESCAR EL PATH (Vital para que funcionen npm, pip y go abajo)
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# 4. Configuración de Lenguajes (Providers)
Write-Host "🐍/🟢/🐹 Configurando Providers..."
python -m pip install --upgrade pynvim
npm install -g neovim tree-sitter-cli
# Instalar el linter y formateador de SQL
pip install sqlfluff
npm install -g sql-formatter
go install gotest.tools/gotestsum@latest
go install github.com/segmentio/golines@latest
gem install neovim

# 5. Crear Symlink del Perfil (El toque final)
$perfilRepo = "$env:LOCALAPPDATA\nvim\backups_config\PowerShell\Microsoft.PowerShell_profile.ps1"
if (Test-Path $perfilRepo) {
    Write-Host "🔗 Vinculando perfil de PowerShell..." -ForegroundColor Yellow
    $perfilDir = Split-Path $PROFILE
    if (!(Test-Path $perfilDir)) { New-Item -ItemType Directory -Path $perfilDir -Force }
    New-Item -ItemType SymbolLink -Path $PROFILE -Target $perfilRepo -Force
}

Write-Host "✅ ¡Proceso completado! REINICIA LA TERMINAL." -ForegroundColor Green
