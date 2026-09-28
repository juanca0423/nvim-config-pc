return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		event = "VeryLazy",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			local luasnip = require("luasnip")
			luasnip.setup({
				keep_roots = true,
				link_roots = true,
				link_children = true,
			})
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true,
			disable_filetype = { "TelescopePrompt", "spectre_panel" },
		},
	},

	-- 3. Iconos y Esttica
	{
		"onsails/lspkind.nvim",
		config = function()
			require("lspkind").init({
				mode = "symbol_text", -- Muestra el icono y el texto (ej: 󰅩 Function)
				preset = "codicons",
				symbol_map = {
					Text = "󰉿",
					Method = "󰆧",
					Function = "󰊕",
					Constructor = "",
					Field = "󰜢",
					Variable = "󰀫",
					Class = "󰠱",
					Interface = "",
					Module = "",
					Property = "󰜢",
					Unit = "󰑭",
					Value = "󰎟",
					Enum = "",
					Keyword = "󰌋",
					Snippet = "",
					Color = "󰏘",
					File = "󰈙",
					Reference = "󰈚",
					Folder = "󰉋",
					EnumMember = "",
					Constant = "󰏿",
					Struct = "󰙅",
					Event = "",
					Operator = "󰆕",
					TypeParameter = "",
				},
			})
		end,
	},
	-- 4. Kulala (Cliente HTTP para Go/APIs)
	{
		"rest-nvim/rest.nvim",
		version = "v3.*",
		ft = { "http", "rest" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"j-hui/fidget.nvim", -- ✅ Agregado: requerido por rest.nvim v3
		},
		config = function()
			require("rest").setup({
				client = "curl",
				result = {
					split = {
						horizontal = false,
						in_place = false,
						keep_focus = true,
					},
				},
			})
		end,
	},
}
