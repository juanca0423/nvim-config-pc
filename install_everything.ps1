# Script de instalación Juanca - Versión Final Pro
Write-Host "🚀 Iniciando instalación de herramientas..." -ForegroundColor Cyan

Set-ExecutionPolicy Bypass -Scope Process -Force

# 1. Instalar Chocolatey (Si no existe)
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "📦 Instalando Chocolatey..."
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

# 2. Instalación de Lenguajes y Core (vía Choco)
Write-Host "🛠️ Instalando lenguajes base..."
# Quitamos ripgrep y fd de aquí para que Winget los maneje (son más nuevos allí)
choco install -y neovim git nodejs-lts python3 go rust make ruby postgresql15 julia jetbrainsmononerdfont oh-my-posh

# 3. Refrescar el PATH
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# 4. Providers y Herramientas de Lenguaje
Write-Host "🐍/🟢/🐹 Configurando Providers..."
pip install --upgrade pynvim sqlfluff
npm install -g neovim tree-sitter-cli sql-formatter
go install gotest.tools/gotestsum@latest
go install github.com/segmentio/golines@latest
gem install neovim

# 5. Herramientas Modernas (vía Winget - Mejores versiones en Windows)
Write-Host "🚀 Instalando herramientas para Snacks.nvim..." -ForegroundColor Cyan
winget install --id Jesseduffield.LazyGit -e --accept-source-agreements
winget install --id ImageMagick.ImageMagick -e
winget install --id sharkdp.fd -e
winget install --id BurntSushi.ripgrep -e

# 6. Symlink del Perfil
$perfilRepo = "$env:LOCALAPPDATA\nvim\backups_config\PowerShell\Microsoft.PowerShell_profile.ps1"
if (Test-Path $perfilRepo) {
    Write-Host "🔗 Vinculando perfil de PowerShell..." -ForegroundColor Yellow
    $perfilDir = Split-Path $PROFILE
    if (!(Test-Path $perfilDir)) { New-Item -ItemType Directory -Path $perfilDir -Force }
    New-Item -ItemType SymbolLink -Path $PROFILE -Target $perfilRepo -Force
}

Write-Host "✅ ¡Proceso completado! REINICIA LA TERMINAL." -ForegroundColor Green
