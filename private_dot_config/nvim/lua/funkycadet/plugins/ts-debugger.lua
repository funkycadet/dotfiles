local dap = require('dap')
local dapui = require('dapui')
dapui.setup({})

-- Automatically open UI when debugging starts
dap.listeners.before.attach["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.launch["dapui_config"] = function()
  dapui.open()
end
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- TS/JS debugger configuration
dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = { 
      vim.fn.stdpath("data") .. "/plugged/js-debug/src/dapDebugServer.js",
      -- vim.fn.stdpath("data") .. "/plugged/vscode-js-debug/dist/src/vsDebugServer.js",
      "${port}" 
    },
  },
  verboseDiagnostics = false,
}

-- Configure TypeScript debug configurations
for _, language in ipairs({ "typescript", "javascript" }) do
  dap.configurations[language] = {
    -- debug single Node.js files
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      protocol = "inspector",
      console = "integratedTerminal",
      outFiles = {"${workspaceFolder}/dist/**/*.js"},
      runtimeExecutable = "ts-node",
      runtimeArgs = {"-r", "ts-node/register"},
    },
    -- debug Node.js processes (make sure to add `--inspect` to your Node.js command)
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require('dap.utils').pick_process,
      cwd = "${workspaceFolder}",
      sourceMaps = true,
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Debugger",
      runtimeExecutable = "node",
      runtimeArgs = {
        -- "--inspect=9229",
        "-r", "ts-node/register",
        "${workspaceFolder}/src/server.ts"
      },
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      protocol = "inspector",
      console = "integratedTerminal",
      -- outFiles = {"${workspaceFolder}/dist/**/*.js"},
      -- resolveSourceMapLocations = {
        -- "${workspaceFolder}/dist/**/*.js",
        -- "${workspaceFolder}/**/*.js",
      -- },
      skipFiles = {
        "<node_internals>/**",
        "**/node_modules/**"
      },
    },
    -- Divider for the launch.json derived configs
    {
      name = "----- ↓ launch.json configs ↓ -----",
      type = "",
      request = "launch",
    },
  }
end


-- python debugger configuration
require("dap-python").setup("python3")

table.insert(dap.configurations.python, {
  type = 'python',
  request = 'launch',
  name = "Debug Django",
  console = "internalConsole",
  program = "${workspaceFolder}/manage.py runserver",
  programArgs = {"runserver", "--noreload"},
  django = true,
  pythonPath = function()
    return vim.fn.exepath('python3')
  end,
})

table.insert(dap.configurations.python, {
  type = 'python',
  request = 'launch',
  name = "Debug FastAPI",
  module = 'uvicorn',
  args = {"main:app", "--reload"},
  jinja = 'true',
})

table.insert(dap.configurations.python, {
  type = 'python',
  request = 'launch',
  name = "Debug Flask",
  module = 'flask',
  -- env = { "FLASK_APP": "app.py", "FLASK_DEBUG": "1" },
  args = {"run", "--no-debugger", "--no-reload"},
  jinja = 'true',
  autoStartBrowser = 'true',
})
