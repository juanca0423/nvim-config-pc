---@diagnostic disable: undefined-global
return {
	"folke/snacks.nvim",
	event = "VimEnter",
	priority = 1000,
	lazy = false,
	opts = {
		-- 1. MÓDULOS DESACTIVADOS (Para máximo rendimiento)
		image = { enabled = false },
		indent = { enabled = false },
		input = { enabled = false },
		scope = { enabled = false },
		scroll = { enabled = false },
		words = { enabled = false },
		debug = { enabled = false },

		-- 2. MÓDULOS ACTIVOS
		terminal = { enabled = true },
		bigfile = { enabled = true },
		winbar = { enabled = true },
		notifier = { enabled = true },

		-- 3. DASHBOARD
		dashboard = {
			animate = { enabled = true },
			enabled = true,
			sections = {
				{ section = "header" },
				{ section = "keys" },
				{ section = "startup" },
			},
			preset = {
				header = [[
   ██████╗  ██████╗      ██╗███████╗
  ██╔════╝ ██╔═══██╗     ██║██╔════╝
  ██║  ███╗██║   ██║     ██║███████╗
  ██║   ██║██║   ██║██   ██║╚════██║
  ╚██████╔╝╚██████╔╝╚█████╔╝███████║
   ╚═════╝  ╚═════╝  ╚════╝ ╚══════╝

      DEVELOPER: JUAN CARLOS
    GO • JS • HTML • CSS STACK]],
				keys = {
					{
						{ title = "Botonera", indent = 4, gap = 0, padding = 1 },
						icon = " ",
						key = "f",
						desc = "Buscar Archivo",
						action = function()
							Snacks.picker.files()
						end,
					},
					{ icon = " ", key = "n", desc = "Nuevo Archivo", action = ":ene | startinsert" },
					{
						icon = " ",
						key = "g",
						desc = "Buscar Texto",
						action = function()
							Snacks.picker.grep()
						end,
					},
					{
						icon = "󰉋 ",
						key = "p",
						desc = "Mis Proyectos",
						action = function()
							Snacks.picker.projects()
						end,
					},
					{
						icon = "󰆼 ",
						key = "s",
						desc = "Bases de Datos (SQL)",
						action = function()
							Snacks.picker.files({ cwd = "C:/Users/Usuario/Documents/Desarrollo/Database" })
						end,
					},
					{ icon = " ", key = "m", desc = "Documentos md", action = ":OpenDocs" },
					{
						icon = " ",
						key = "r",
						desc = "Recientes",
						action = function()
							Snacks.picker.recent()
						end,
					},
					{
						icon = " ",
						key = "c",
						desc = "Configuración",
						action = function()
							Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
						end,
					},
					{ icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy" },
					{ icon = " ", key = "q", desc = "Salir", action = ":qa" },
					{ title = "Documentación y Enlaces", indent = 4, gap = 0, padding = 1 },
					{
						icon = "󰟓 ",
						key = "G",
						desc = "Go Packages & Docs",
						action = function()
							vim.ui.open("https://pkg.go.dev/")
						end,
					},
					{
						icon = "󰙯 ",
						key = "v",
						desc = "Neovim Docs",
						action = function()
							vim.ui.open("https://neovim.io/doc/")
						end,
					},
					{
						icon = " ",
						key = "R",
						desc = "Mis Proyectos (GitHub)",
						action = function()
							vim.ui.open("https://github.com/juanca0423/")
						end,
					},
				},
				keys2 = {},
			},
		},

		-- 4. PICKER
		picker = {
			enabled = true,
			sources = {
				files = { hidden = true },
			},
		},

		-- 5. EXPLORADOR
		explorer = {
			enabled = true,
			replace_netrw = true,
			win = {
				list = {
					keys = {
						["o"] = "open_external",
						["<leader>gx"] = "open_external",
					},
				},
			},
			actions = {
				open_external = function(_, item)
					if item and item.file then
						vim.ui.open(item.file)
					end
				end,
			},
		},

		-- 6. ESTILOS
		styles = {
			explorer = {
				width = 35,
				edge = "left",
				title = function()
					return "   " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":~") .. " "
				end,
				title_pos = "center",
				win = {
					border = "rounded",
					wo = {
						winbar = "",
					},
				},
				sections = {
					{ section = "tree" },
				},
			},
		},
	},
	config = function(_, opts)
		require("snacks").setup(opts)

		local augroup = vim.api.nvim_create_augroup("SnacksOptimizations", { clear = true })

		-- Retorno al Dashboard si no quedan buffers abiertos
		vim.api.nvim_create_autocmd("BufDelete", {
			group = augroup,
			callback = function()
				vim.schedule(function()
					local valid_bufs = vim.tbl_filter(function(b)
						return vim.api.nvim_buf_is_valid(b) and vim.bo[b].buflisted
					end, vim.api.nvim_list_bufs())

					if #valid_bufs == 0 and vim.bo.filetype ~= "snacks_dashboard" then
						require("snacks").dashboard.open()
					end
				end)
			end,
		})

		-- Apertura automática de imágenes en el visor por defecto de Windows
		vim.api.nvim_create_autocmd("BufReadCmd", {
			group = augroup,
			pattern = { "*.png", "*.jpg", "*.jpeg", "*.webp", "*.gif" },
			callback = function(ev)
				vim.ui.open(ev.file)
				vim.api.nvim_buf_delete(ev.buf, { force = true })
			end,
		})

		-- KEYMAPS PRINCIPALES
		vim.keymap.set("n", "<leader>gx", function()
			local file = vim.fn.expand("<cfile>")
			if file ~= "" then
				vim.ui.open(file)
			end
		end, { desc = "Abrir imagen/enlace externo" })

		vim.keymap.set("n", "<leader>t", function()
			Snacks.explorer()
		end, { desc = "Explorador" })

		vim.keymap.set("n", "<leader>lg", function()
			Snacks.lazygit()
		end, { desc = "Abrir Lazygit" })

		vim.keymap.set("n", "<leader>aa", function()
			Snacks.dashboard.open()
		end, { desc = "Dashboard" })
	end,
}
