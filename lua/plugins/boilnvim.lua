return {
	"stevearc/oil.nvim",
	opts = { columns = { "icon" } },
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			columns = { "icon" }, -- Muestra iconos a la izquierda
			keymaps = {
				["<CR>"] = "actions.select",
				["<C-h>"] = false, -- Evita conflictos con navegación de ventanas
				["<C-l>"] = false,
				["-"] = "actions.parent",
			},
			view_options = {
				show_hidden = true,
			},
		})
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Abrir Oil" })

		-- Workaround: disable diagnostics inside Oil buffers to avoid
		-- diagnostic reads on ephemeral explorer buffers which can
		-- trigger "Index out of bounds" in some versions/plugins.
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "oil",
			callback = function(args)
				if vim.diagnostic and type(vim.diagnostic.disable) == "function" then
					-- disable diagnostics for this buffer (no specific namespace)
					vim.diagnostic.disable(nil, args.buf)
				end
			end,
		})
	end,
}
