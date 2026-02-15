local function conf()
  local dap = require("dap")
  local dapui = require("dapui")

  dapui.setup()

  -- 1. CONFIGURACIÓN PARA NODE.JS (Windows)
  dap.adapters["pwa-node"] = {
    type = "server",
    host = "127.0.0.1",
    port = "${port}",
    executable = {
      command = "node",
      -- Ruta corregida para Mason en Windows
      args = {
        vim.fn.expand("$LOCALAPPDATA/nvim-data/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"),
        "${port}",
      },
    },
  }

  -- 2. CONFIGURACIÓN PARA GO (Windows)
  -- Buscamos el dlv.exe automáticamente en tu PATH de Mason
  require('dap-go').setup({
    delve = {
      path = "dlv", -- Si Mason está en el PATH, solo "dlv" basta en Windows
      initialize_timeout_sec = 20,
    },
  })

  -- 3. ESTÉTICA DE BREAKPOINTS
  vim.fn.sign_define('DapBreakpoint', { text = '󰏃', texthl = 'DiagnosticError' })
  vim.fn.sign_define('DapStopped', { text = '󰁕', texthl = 'DiagnosticInfo' })

  -- 4. AUTOMATIZACIÓN DE LA UI
  dap.listeners.before.attach.dapui_config = function() dapui.open() end
  dap.listeners.before.launch.dapui_config = function() dapui.open() end
  -- Comentado para que no se cierre sola la ventana al terminar (útil para ver errores)
  -- dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
end

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "leoluz/nvim-dap-go",
    "nvim-neotest/nvim-nio",
  },
  config = conf
}
