-- Función para obtener el estado de Harpoon (Mejorada para Windows)
local function harpoon_status()
  local ok, harpoon = pcall(require, "harpoon")
  if not ok then return "" end

  local marks = harpoon:list().items
  local current_file_path = vim.fn.expand("%:p:.")

  -- Normalizar barras para Windows
  current_file_path = current_file_path:gsub("\\", "/")

  for i, item in ipairs(marks) do
    local item_value = item.value:gsub("\\", "/")
    if item_value == current_file_path then
      return "󰛢 " .. i
    end
  end
  return ""
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'ThePrimeagen/harpoon' },
  config = function()
    require('lualine').setup({
      options = {
        theme = 'catppuccin',
        globalstatus = true, -- Recomendado para v0.11
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' }
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = {
          { 'filename',     file_status = true,                      path = 1 },
          { harpoon_status, color = { fg = "#f5c2e7", gui = "bold" } } -- Color rosa Catppuccin
        },
        lualine_x = {
          {
            'diagnostics',
            symbols = { error = ' ', warn = ' ', info = ' ', hint = '󰌵 ' },
          },
          'filetype',
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      }
    })
  end
}
