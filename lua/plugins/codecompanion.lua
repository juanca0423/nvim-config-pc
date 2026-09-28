return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
		keys = {
			{ "<leader>iq", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "AI Chat (Toggle)" },
			{ "<leader>ii", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, desc = "AI Inline Prompt" },
			{ "<leader>ie", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "AI Actions / Explain" },
		},
		config = function()
			require("codecompanion").setup({
				strategies = {
					chat = {
						adapter = "ollama",
						opts = {
							system_prompt = "Eres un programador experto. DEBES responder SIEMPRE en español de forma clara, concisa y profesional.",
						},
					},
					inline = {
						adapter = "ollama",
						opts = {
							system_prompt = "Eres un programador experto. DEBES responder SIEMPRE en español.",
						},
					},
				},
				adapters = {
					ollama = function()
						return require("codecompanion.adapters").extend("ollama", {
							schema = {
								model = {
									default = "deepseek-coder-v2:16b-lite-instruct-q2_K",
								},
							},
						})
					end,
				},
			})

			-- Autocomando para apagar los modelos al salir de Neovim
			vim.api.nvim_create_autocmd("VimLeavePre", {
				callback = function()
					vim.fn.jobstart({ "ollama", "stop", "deepseek-coder-v2:16b-lite-instruct-q2_K" })
					vim.fn.jobstart({ "ollama", "stop", "qwen2.5-coder:7b" })
				end,
			})
		end,
	},
}
