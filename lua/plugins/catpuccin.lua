return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	lazy = false,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
			term_colors = true,
			-- Metemos tus colores aquí para que se compilen con el tema
			custom_highlights = function(colors)
				return {
					CursorLineNr = { fg = colors.peach, bold = true }, -- #FAB387 es 'peach'
					LineNr = { fg = colors.yellow }, -- #F9E2AF es 'yellow'
					FoldColumn = { fg = colors.blue, bold = true }, -- #89B4FA es 'blue'
					SignColumn = { bg = "none" },
				}
			end,
			integrations = {
				bufferline = true,
				nvimtree = true,
				treesitter = true,
				telescope = { enabled = true },
				native_lsp = { enabled = true },
				render_markdown = true, -- Para que tus docs se vean bien
			},
			Dragon = { enabled = true },
		})

		vim.cmd.colorscheme("catppuccin")
	end,
}
