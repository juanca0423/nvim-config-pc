return {
  "robitx/gp.nvim",
  config = function()
    -- SUSTITUYE ESTA LLAVE POR LA TUYA REAL
    local my_key = "AIzaSyCIPjmgyWf0NvDIinVsuVRr08QoB3D71rA" 

    require("gp").setup({
      providers = {
        googleai = {
          endpoint = "https://generativelanguage.googleapis.com/v1beta/models/{{model}}:streamGenerateContent?key=" .. my_key,
          secret = my_key,
        },
      },
      agents = {
        {
          name = "Gemini",
          chat = true,
          command = true,
          provider = "googleai",
          model = { model = "gemini-1.5-flash" }, -- Usamos flash que es más rápido para probar
          system_prompt = "Eres Gemini, un asistente experto en Neovim y programación.",
        },
      },
      -- Forzamos a que Gemini sea el único agente activo
      default_chat_agent = "Gemini",
      default_command_agent = "Gemini",
    })

    -- Atajos de teclado
    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "<leader>ac", "<cmd>GpChatNew<cr>", opts)
    -- Si falla el guardado, usa Ctrl+g dos veces para forzar respuesta
    vim.keymap.set({"n", "i"}, "<C-g><C-g>", "<cmd>GpChatRespond<cr>", opts)
  end,
}
