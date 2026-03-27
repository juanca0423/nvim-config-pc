-- Función para obtener el estado de Harpoon (Mejorada para Windows)
local function harpoon_status()
	local ok, harpoon = pcall(require, "harpoon")
	if not ok then
		return ""
	end

	local list = harpoon:list()
	-- Normalizamos rutas para evitar el error de la doble barra en Windows
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
	-- ELIMINADO: nvim-web-devicons ya no es necesario por Snacks
	dependencies = { "ThePrimeagen/harpoon" },
	config = function()
		local status_cat, _ = pcall(require, "catppuccin")
		local my_theme = "auto"

		if status_cat then
			local cp = require("catppuccin.palettes").get_palette("mocha")
			my_theme = {
				normal = {
					a = { bg = cp.blue, fg = cp.mantle, gui = "bold" },
					b = { bg = cp.surface1, fg = cp.blue },
					c = { bg = cp.mantle, fg = cp.text },
				},
				insert = { a = { bg = cp.green, fg = cp.mantle, gui = "bold" } },
				visual = { a = { bg = cp.mauve, fg = cp.mantle, gui = "bold" } },
				replace = { a = { bg = cp.red, fg = cp.mantle, gui = "bold" } },
				inactive = { a = { bg = cp.mantle, fg = cp.blue } },
			}
		end

		require("lualine").setup({
			options = {
				theme = my_theme,
				globalstatus = true,
				icons_enabled = true,
				disabled_filetypes = {
					-- ACTUALIZADO: Quitamos NvimTree y añadimos los de Snacks
					statusline = { "alpha", "dashboard", "snacks_dashboard", "snacks_explorer" },
					winbar = { "alpha", "dashboard", "snacks_dashboard", "snacks_explorer" },
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
