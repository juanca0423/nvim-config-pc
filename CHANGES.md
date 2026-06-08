# Cambios recientes

- fix(oil): Protege la llamada a `vim.diagnostic.disable` y cierra correctamente el archivo generado `CHEATSHEET.md`.

Descripción:

- Se añadió una comprobación para `vim.diagnostic.disable` antes de invocarla en `lua/plugins/boilnvim.lua`.
- Se cerró explícitamente el descriptor de archivo en `lua/config/generate_cheatsheet.lua` y se movió el `print` fuera del heredoc.

Motivo:

- Evitar errores en buffers efímeros del explorador `oil.nvim` cuando no todas las APIs de diagnóstico están disponibles.

Prueba rápida:

1. Abrir Neovim y ejecutar `:Oil`.
2. Confirmar que no aparece el error `attempt to call field 'disable' (a nil value)`.
