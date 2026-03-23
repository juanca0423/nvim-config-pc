return {
  'nacro90/numb.nvim',
  event = "BufRead",
  config = function()
    require('numb').setup({
      show_numbers = true,    -- Muestra el número de línea en el preview
      show_cursorline = true, -- Resalta la línea a la que vas a saltar
      number_only = false,    -- Si escribes :10, funciona igual
    })
  end
}
