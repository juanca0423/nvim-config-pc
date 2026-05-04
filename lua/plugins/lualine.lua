-- Función para obtener el estado de Harpoon (Mejorada para Windows)
local function harpoon_status()
	local ok, harpoon = pcall(require, "harpoon")
	if not ok then
		return ""
	end

	local list = harpoon:list()
	local current_file_path = vim.fn.expand("%:p:."):gsub("\\", "/")

	for i, item in ipairs(list.items) do
		if item.value:gsub("\\", "/") == current_file_path then
			return "󰛢 " .. i
		end
	end
	return ""
end

return {
	"nvim-lualine/lualine.nvim",
	event = "BufReadPost",
	dependencies = {
		"ThePrimeagen/harpoon",
		"catppuccin/nvim",
	},
	config = function()
		-- 1. Intentamos cargar los colores de catppuccin directamente
		local status_cat, cp = pcall(require, "catppuccin.palettes")
		local my_theme = "auto"

		if status_cat then
			-- Usamos la paleta mocha
			local mocha = cp.get_palette("mocha")

			-- Cargamos el tema base de lualine para catppuccin
			my_theme = require("lualine.themes.catppuccin-mocha")

			-- 2. Sobrescribimos solo las partes específicas que quieres personalizar
			-- Esto asegura que el resto del tema (command mode, terminal, etc.) funcione
			my_theme.normal.a = { bg = mocha.blue, fg = mocha.mantle, gui = "bold" }
			my_theme.normal.b = { bg = mocha.surface1, fg = mocha.blue }
			my_theme.normal.c = { bg = mocha.mantle, fg = mocha.text }

			my_theme.insert.a = { bg = mocha.green, fg = mocha.mantle, gui = "bold" }
			my_theme.visual.a = { bg = mocha.mauve, fg = mocha.mantle, gui = "bold" }
			my_theme.replace.a = { bg = mocha.red, fg = mocha.mantle, gui = "bold" }
			my_theme.inactive.a = { bg = mocha.mantle, fg = mocha.blue }
		end

		require("lualine").setup({
			options = {
				theme = my_theme,
				globalstatus = true,
				icons_enabled = true,
				disabled_filetypes = {
					statusline = { "dashboard", "snacks_dashboard", "snacks_explorer" },
					winbar = { "dashboard", "snacks_dashboard", "snacks_explorer" },
				},
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = {
					{ "filename", file_status = true, path = 1 },
					{ harpoon_status, color = { fg = "#f5c2e7", gui = "bold" } },
				},
				lualine_x = {
					{
						"diagnostics",
						symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
					},
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
