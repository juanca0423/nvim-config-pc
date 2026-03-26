return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		-- Corrección de PATH para Windows (VITAL)
		local separator = ";"
		local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
		vim.env.PATH = mason_bin .. separator .. vim.env.PATH

		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = { "gopls", "lua_ls", "ts_ls", "html", "sqls" },
		})

		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local servers = { "lua_ls", "gopls", "ts_ls", "html", "cssls", "sqls" }

		for _, server in ipairs(servers) do
			local opts = { capabilities = capabilities }

			-- Ajustes específicos por lenguaje

			-- Ajustes específicos por lenguaje
			if server == "gopls" then
				opts.settings = {
					gopls = {
						completeUnimported = true,
						gofumpt = true,
						analyses = { unusedparams = true, shadow = true },
						staticcheck = true,
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							parameterNames = true,
						},
					},
				}
			elseif server == "sqls" then
				opts.settings = {
					sqls = {
						connections = {
							{
								driver = "postgresql",
								-- Cambia juanca y tu password aquí para que conecte a tu DB de EEFF
								dataSourceName = string.format(
									"host=127.0.0.1 port=5432 user=juanca password=%s dbname=eeff",
									os.getenv("DB_PASS") or ""
								),
							},
						},
					},
				}
			elseif server == "ts_ls" or server == "vtsls" then
				opts.settings = {
					typescript = {
						updateImportsOnFileMove = { enabled = "always" },
						suggest = { completeFunctionCalls = true },
						inlayHints = {
							parameterNames = { enabled = "all" },
							variableTypes = { enabled = true },
						},
					},
					javascript = {
						suggest = { completeFunctionCalls = true },
						inlayHints = { parameterNames = { enabled = "all" } },
					},
				}
			elseif server == "lua_ls" then
				opts.settings = { Lua = { diagnostics = { globals = { "vim" } } } }
			elseif server == "cssls" then
				opts.settings = { css = { validate = true, lint = { unknownAtRules = "ignore" } } }
			end

			-- Configuración nativa v0.11
			-- Si falla vim.lsp.config, usamos el fallback de lspconfig
			local ok, _ = pcall(function()
				vim.lsp.config(server, opts)
				vim.lsp.enable(server)
			end)

			if not ok then
				require("lspconfig")[server].setup(opts)
			end
		end
		-- 1. Asegurar que Neovim vea los .hbs como HTML (Para resaltado de sintaxis)
		vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
			pattern = "*.hbs",
			callback = function()
				vim.bo.filetype = "html"
			end,
		})

		-- Auto-comando unificado SOLO para lo que el LSP debe hacer (Imports)
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.go",
			callback = function()
				-- Conform ya formatea, así que aquí SOLO organizamos imports
				vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
			end,
		})
		-- 1. Definimos los iconos (Nerd Fonts)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }

		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- 2. Configuración de cómo se ven los errores en pantalla
		vim.schedule(function()
			vim.diagnostic.config({
				virtual_text = {
					prefix = "●", -- Un punto elegante al final de la línea con el error
				},
				update_in_insert = false, -- No nos molesta mientras escribimos
				underline = true,
				severity_sort = true,
				float = {
					focused = false,
					style = "minimal",
					border = "rounded", -- Bordes redondeados para que se vea premium
					source = "always",
					header = "",
					prefix = "",
				},
			})
		end)
	end,
}
