-- local dap = require('dap')
-- local dapui = require('dapui')
-- dapui.setup({})

-- -- Automatically open UI when debugging starts
-- dap.listeners.before.attach["dapui_config"] = function()
--   dapui.open()
-- end
-- dap.listeners.before.launch["dapui_config"] = function()
--   dapui.open()
-- end
-- dap.listeners.after.event_initialized["dapui_config"] = function()
--   dapui.open()
-- end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dapui.close()
-- end


-- -- python debugger configuration
-- -- local dap-python = require('dap-python')
-- -- require("dap-python").setup("/home/ericalaribe/.local/bin/debugpy")
-- require("dap-python").setup("python3")

-- table.insert(dap.configurations.python, {
--   type = 'python',
--   request = 'launch',
--   name = "Debug Django",
--   console = "internalConsole",
--   program = "${workspaceFolder}/manage.py",
--   programArgs = {"runserver", "--noreload"},
--   django = true,
--   pythonPath = function()
--     return vim.fn.exepath('python3')
--   end,
-- })

-- table.insert(dap.configurations.python, {
--   type = 'python',
--   request = 'launch',
--   name = "Debug FastAPI",
--   module = 'uvicorn',
--   args = {"main:app", "--reload"},
--   jinja = 'true',
-- })

-- table.insert(dap.configurations.python, {
--   type = 'python',
--   request = 'launch',
--   name = "Debug Flask",
--   module = 'flask',
--   -- env = { "FLASK_APP": "app.py", "FLASK_DEBUG": "1" },
--   args = {"run", "--no-debugger", "--no-reload"},
--   jinja = 'true',
--   autoStartBrowser = 'true',
-- })
