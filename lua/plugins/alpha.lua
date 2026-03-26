return {
	"goolord/alpha-nvim",
	lazy = false,
	priority = 1000,
	config = function()
		local dashboard = require("alpha.themes.dashboard")

		-- HEADER (Tu arte ASCII original)
		dashboard.section.header.val = {
			[[                                     ]],
			[[    ██████╗  ██████╗      ██╗███████╗]],
			[[   ██╔════╝ ██╔═══██╗     ██║██╔════╝]],
			[[   ██║  ███╗██║   ██║     ██║███████╗]],
			[[   ██║   ██║██║   ██║██   ██║╚════██║]],
			[[   ╚██████╔╝╚██████╔╝╚█████╔╝███████║]],
			[[    ╚═════╝  ╚═════╝  ╚════╝ ╚══════╝]],
			[[                                     ]],
			[[      DEVELOPER: JUAN CARLOS         ]],
			[[    GO LANG • JAVASCRIPT STACK       ]],
			[[                                     ]],
		}
		dashboard.section.header.opts.hl = "Keyword"

		-- BOTONES (Con tus colores originales)
		local function button(sc, txt, keybind, hl)
			local b = dashboard.button(sc, txt, keybind)
			b.opts.hl = hl or "Function"
			b.opts.hl_shortcut = "Number"
			return b
		end

		dashboard.section.buttons.val = {
			button("f", "󰱼  BUSCAR ARCHIVO", "<cmd>Telescope find_files<CR>", "Label"),
			button("r", "󱋡  RECIENTES", "<cmd>Telescope oldfiles<CR>", "Special"),
			button("s", "󰺮  BUSCAR TEXTO", "<cmd>Telescope live_grep<CR>", "Function"),
			button("e", "󰙅  EXPLORADOR", "<cmd>NvimTreeOpen<CR>", "Type"),
			button("c", "  AJUSTES", "<cmd>edit $MYVIMRC<CR>", "Constant"),
			button("q", "󰈆  SALIR", "<cmd>qa<CR>", "Error"),
		}

		dashboard.section.footer.val = "󰚚  READY TO CODE"
		dashboard.section.footer.hl = "Comment"

		-- CONFIGURACIÓN Y FIX NUCLEAR PARA WINDOWS
		require("alpha").setup(dashboard.opts)

		-- Evita el parpadeo y limpia el buffer vacío inicial
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				if vim.fn.argc() == 0 and vim.api.nvim_buf_get_name(0) == "" then
					vim.cmd("silent! bdelete 1")
					vim.cmd("Alpha")
				end
			end,
		})
	end,
}
