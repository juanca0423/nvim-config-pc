return {
  "mg979/vim-visual-multi",
  branch = "master",
  init = function()
    -- Configuraciones globales antes de que cargue el plugin
    vim.g.VM_leader = ","       -- Cambia el líder de VM si lo deseas
    vim.g.VM_maps = {
      ['Find Under'] = '<C-n>', -- Ctrl+n selecciona la palabra y busca la siguiente (como Ctrl+D en VS Code)
      ['Find Subword Under'] = '<C-n>',
    }
  end,
}
