return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<c-\>]], -- Shortcut universal Ctrl + \
      hide_numbers = true,
      shade_terminals = true,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      direction = 'float', -- Aquí es donde definimos que sea FLOTANTE
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = 'curved', -- Bordes redondeados estilo Windows 11
        winblend = 3,
      },
    })
-- Esto va dentro del config = function() antes del final
    function _G.set_terminal_keymaps()
      local opts = {buffer = 0}
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    end

    -- Solo aplicar a terminales
    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    -- Shortcut personalizado usando tu Leader (coma)
    local opts = { noremap = true, silent = true }
    vim.keymap.set('n', '<leader>tf', '<Cmd>ToggleTerm<CR>', opts)
  end
}
