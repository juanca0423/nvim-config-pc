return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleStat", "TSTree", "TSUpdate" },
		config = function()
			-- Usamos stdpath("data") y nos aseguramos de que termine en /site
			local data_path = vim.fn.stdpath("data"):gsub("\\", "/")
			local parser_path = data_path .. "/site"

			-- IMPORTANTE: Neovim necesita ver la carpeta 'parser' dentro de 'site'
			-- para que Treesitter reconozca los binarios .so o .dll
			if vim.fn.isdirectory(parser_path .. "/parser") == 0 then
				vim.fn.mkdir(parser_path .. "/parser", "p")
			end

			-- Agregamos al inicio del runtimepath para prioridad
			vim.opt.runtimepath:prepend(parser_path)

			local ok, configs = pcall(require, "nvim-treesitter.configs")
			if not ok then
				return
			end

			configs.setup({
				-- Indicamos a TS dónde instalar físicamente los parsers
				install_dir = parser_path,
				ensure_installed = {
					"go",
					"lua",
					"sql",
					"html",
					"javascript",
					"typescript",
					"markdown",
					"css",
					"glimmer",
					"handlebars",
					"powershell",
				},
				highlight = {
					enable = true,
					disable = function(_, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local oki, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if oki and stats and stats.size > max_filesize then
							return true
						end
					end,
				},
				indent = { enable = true },
			})

			-- MOVIMOS EL COMANDO AQUÍ ADENTRO:
			vim.api.nvim_create_user_command("TSCheckPath", function()
				local p_path = vim.fn.stdpath("data"):gsub("\\", "/") .. "/site/parser"
				print("📍 Buscando parsers en: " .. p_path)
				local files = vim.fn.readdir(p_path)
				if #files > 0 then
					print("✅ Encontrados " .. #files .. " archivos.")
					for i = 1, math.min(3, #files) do
						print("  - " .. files[i])
					end
				else
					print("⚠️  La carpeta está vacía.")
				end
			end, {})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPost",
		opts = { max_lines = 3 },
	},
}
