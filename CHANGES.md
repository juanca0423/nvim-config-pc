# Cambios recientes

* **En tu carpeta principal (`.../Local/nvim`):**
```bash
# 1. Haces tus cambios y los pruebas en Neovim
# 2. Agregas los archivos modificados
git add .
# 3. Guardas los cambios localmente en la rama docs/add-changes-oil-fix
git commit -m "docs: actualizar notas de oil y cambios de entorno"

```


* **Luego sí, saltas al worktree de `main`:**
```bash
cd C:/Users/Usuario/AppData/Local/nvim.worktrees/agents-actualizar-repositorio-github
git merge docs/add-changes-oil-fix
git push origin main

```
¡Con gusto! El concepto de **Git Worktrees** parece magia la primera vez que lo usas, pero en realidad es una característica nativa de Git (añadida por allá de 2015) diseñada precisamente para quitarte el dolor de cabeza de andar haciendo `git stash` o checkouts apurados cuando estás a mitad de un cambio.

Vamos a desmenuzar exactamente qué son, cómo terminaron configurados en tu máquina y cómo puedes crear los tuyos desde cero.

---

### 🧠 El Concepto: ¿Qué es un Worktree?

Normalmente, cuando haces un `git clone`, Git crea una estructura con dos partes:

1. Una carpeta oculta llamada `.git` (el **repositorio** con todo el historial comprimido).
2. Tus archivos visibles (el **árbol de trabajo** o *working tree*).

Por defecto, solo puedes tener **una rama activa a la vez** en tus archivos visibles. Si quieres ver otra rama, tienes que cambiar tus archivos completos (`git checkout`).

**Un Git Worktree rompe esta limitación.** Le permite a una única carpeta oculta `.git` controlar **múltiples carpetas físicas diferentes** en tu disco duro al mismo tiempo. Cada carpeta física está vinculada a una rama distinta.

---

### 🔍 ¿Cómo se creó la estructura que tienes actualmente?

En algún momento, para automatizar o actualizar tu repositorio de configuraciones de Neovim sin ensuciar tu espacio de trabajo actual, se ejecutó un comando de inicialización de worktree. El proceso detrás de escena fue el siguiente:

1. **Estando en tu carpeta principal:** `C:\Users\Usuario\AppData\Local\nvim`
2. **Se ejecutó un comando estructurado como este:**
```bash
git worktree add ../nvim.worktrees/agents-actualizar-repositorio-github main

```



**¿Qué hizo Git exactamente en ese segundo?**

* Creó una nueva carpeta física en la ruta especificada (`.../nvim.worktrees/agents-actualizar-repositorio-github`).
* Conectó esa carpeta de forma interna con el `.git` de tu carpeta principal.
* Le asignó la rama `main` de manera exclusiva a esa nueva ubicación.
* Bloqueó la rama `main` para que no pudieras hacerle un `checkout` accidental en tu carpeta principal (el error que te dio al principio).

---

### 🛠️ Guía Paso a Paso: Cómo crear y administrar tus propios Worktrees

Si mañana estás trabajando en un proyecto (por ejemplo, tu backend en Go o tus herramientas) y quieres replicar este flujo para trabajar en una función nueva sin tocar tu código base, estos son los comandos que debes usar:

#### 1. Crear un nuevo espacio de trabajo (Worktree)

Si estás en tu proyecto principal y te piden arreglar un bug urgente en una rama nueva llamada `fix-bug-contable`, ejecutas:

```bash
git worktree add ../proyecto-bugfix -b fix-bug-contable

```

* `../proyecto-bugfix`: Es la carpeta física nueva donde se descargará el código.
* `-b fix-bug-contable`: Le dice a Git que cree una rama nueva para esa carpeta.
* *¡Listo!* Ahora tienes dos carpetas en tu disco duro ejecutando dos ramas distintas del mismo proyecto en paralelo.

#### 2. Listar tus espacios activos

Para recordar qué carpetas tienes abiertas y a qué ramas responden (como el comando que ejecutaste hace un momento):

```bash
git worktree list

```

#### 3. Eliminar un Worktree cuando termines

Una vez que hiciste el merge, subiste los cambios a GitHub y ya no necesitas esa carpeta secundaria ocupando espacio en tu disco, la limpias de forma segura con:

```bash
git worktree remove ../proyecto-bugfix

```

* **Nota:** Esto borra la carpeta física y le avisa a tu repositorio principal que esa rama vuelve a estar libre, pero **no borra tus commits de Git**. Tu historial ya quedó a salvo en el repositorio.

---

### 🏆 ¿Por qué es una ventaja enorme para ti?

* **No pierdes el foco:** Si estás modificando un archivo de configuración complejo en Neovim y necesitas verificar rápido cómo se ve el `main` original, no tienes que borrar, guardar en stash o arriesgar tus cambios. Solo abres otra terminal, vas a la otra carpeta y listo.
* **Compilaciones aisladas:** En entornos de desarrollo como Go o entornos pesados, puedes compilar pruebas en una carpeta sin romper los binarios o las pruebas que se están ejecutando en la otra.

¡De una! Vamos a diseñar un script de automatización espectacular en **PowerShell** (manteniendo esa estética limpia y profesional que te gusta) para que puedas crear un nuevo entorno de trabajo con Git Worktrees usando un solo comando.

La idea es que no tengas que recordar las rutas relativas ni escribir comandos largos. Crearemos una función que automatice todo el proceso: crear la rama, generar la carpeta física en el lugar correcto, configurar el entorno y dejarte listo para tirar código.

### 🛠️ El Script: `New-GitWorktree`

Puedes añadir esta función directamente a tu perfil de PowerShell. Para abrir tu perfil en Neovim desde la terminal, recuerda que puedes usar:

```bash
v $PROFILE

```

Pega esta función al final de tu archivo de configuración:

```powershell
function New-GitWorktree {
    param (
        [Parameter(Mandatory=$true)]
        [string]$BranchName,   # El nombre de la rama/tarea (ej. 'feature/ajustes-costos')
        [string]$FolderName    # Opcional: Nombre de la carpeta si quieres que sea diferente de la rama
    )

    # 1. Verificar si estamos dentro de un repositorio de Git
    if (-not (git rev-parse --is-inside-work-tree 2>$null)) {
        Write-Host "❌ Error: ¡No estás dentro de un repositorio de Git!" -ForegroundColor Red
        return
    }

    # 2. Definir nombres limpios para la carpeta secundaria
    # Si no nos dan un nombre de carpeta, limpiamos el nombre de la rama (quitamos barras si las hay)
    if (-not $FolderName) {
        $FolderName = $BranchName -replace '.*/', ''
    }

    # Determinamos la ruta base del repositorio actual para saber dónde guardar el worktree
    $RepoRoot = (git rev-parse --show-toplevel).Trim()
    $RepoName = Split-Path $RepoRoot -Leaf
    
    # Creamos la carpeta de los worktrees al mismo nivel o en una carpeta .worktrees dedicada
    # Siguiendo tu estructura, lo organizaremos en una carpeta ".worktrees" limpia
    $WorktreePath = Join-Path (Split-Path $RepoRoot -Parent) "$RepoName.worktrees/$FolderName"

    Write-Host "`n🚀 Inicializando nuevo entorno Git Worktree..." -ForegroundColor Cyan
    Write-Host "📂 Repositorio base:  $RepoName" -ForegroundColor Gray
    Write-Host "🌿 Nueva rama:         $BranchName" -ForegroundColor Lavender
    Write-Host "📍 Destino físico:    $WorktreePath" -ForegroundColor Gray
    Write-Host "--------------------------------------------------" -ForegroundColor DarkGray

    # 3. Ejecutar el comando nativo de Git
    # -b crea la rama si no existe; si ya existe, puedes quitar el -b, pero este flujo asume tareas nuevas
    git worktree add $WorktreePath -b $BranchName

    if ($LASTEXITCODE -eq 0) {
        Write-Host "`n✨ ¡Entorno creado con éxito!" -ForegroundColor Green
        Write-Host "👉 Para empezar a trabajar en esta rama, ejecuta:" -ForegroundColor Yellow
        Write-Host "   cd `"$WorktreePath`"" -ForegroundColor White
    } else {
        Write-Host "`n❌ Hubo un error al intentar crear el worktree. Revisa los mensajes de Git arriba." -ForegroundColor Red
    }
}

# Alias corto para el Dashboard o uso rápido
Set-Alias -Name gw -Value New-GitWorktree

```

---

### 🚀 Cómo usar tu nueva herramienta

Una vez guardado tu perfil, reinicia la terminal (o ejecuta `. $PROFILE` para recargarla). Ahora tu flujo de desarrollo para cualquier nueva característica, reparación en la base de datos o cambios en tu frontend se vuelve absurdamente rápido:

**Ejemplo 1: Crear una tarea de mantenimiento rápido**
Estás en tu carpeta principal y te surge un cambio urgente en la nomenclatura contable:

```bash
gw feature/ajuste-iva

```

* **¿Qué hace?** Crea automáticamente la rama `feature/ajuste-iva` y te genera una carpeta limpia llamada `tu-proyecto.worktrees/ajuste-iva` lista para usar.

**Ejemplo 2: Personalizar el nombre de la carpeta**
Si la rama es muy larga pero quieres una carpeta corta:

```bash
gw fix/error-linea-96-querys fix-query

```

* **¿Qué hace?** Crea la rama larga en Git, pero en tu disco duro la carpeta física se llamará simplemente `fix-query`.

---

### 🧼 Tip adicional: ¿Y para limpiar rápido cuando termines?

Para cerrar el círculo de la automatización, puedes añadir este mini-alias en tu perfil para cuando hagas el `push` final a GitHub y quieras deshacerte de la carpeta física que ya no usas:

```powershell
function Remove-GitWorktree {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Path
    )
    git worktree remove $Path
}
Set-Alias -Name gwr -Value Remove-GitWorktree

```

Así, cuando termines y estés de vuelta en tu directorio principal, solo escribes:

```bash
gwr ../nombre-de-la-carpeta

```

Y Git borrará la carpeta del disco duro y liberará la rama automáticamente, manteniendo tu sistema impecable.

¿Qué te parece la estructura del script? Pruébalo en tu entorno y me cuentas cómo lo sientes. ¡Lleva el flujo de trabajo a otro nivel!
