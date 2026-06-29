return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      dap.adapters.python = {
        type = "executable",
        command = "python3",
        args = { "-m", "debugpy.adapter" },
      }
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
        },
      }

      dap.adapters.node2 = function(cb, cfg)
        if cfg.type == "node" then
          cb({ type = "server", host = cfg.host or "127.0.0.1", port = cfg.port or 9229 })
        end
      end
      dap.configurations.javascript = {
        {
          type = "node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          runtimeExecutable = "node",
          runtimeArgs = { "--inspect-brk" },
          port = 9229,
        },
      }
      dap.configurations.typescript = {
        {
          type = "node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          runtimeExecutable = "node",
          runtimeArgs = { "--inspect-brk" },
          port = 9229,
        },
      }

      dap.adapters.go = {
        type = "executable",
        command = "dlv",
        args = { "dap" },
      }
      dap.configurations.go = {
        {
          type = "go",
          request = "launch",
          name = "Debug",
          program = "${fileDirname}",
        },
      }

      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
      vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
      vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step out" })
      vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run last" })
      vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "Restart" })
      vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Terminate" })
      vim.keymap.set("n", "<leader>dB", dap.list_breakpoints, { desc = "List breakpoints" })
    end,
  },
  {
    "mxsdev/nvim-dap-node",
    enabled = false,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dapui = require("dapui")
      dapui.setup()
      local dap = require("dap")
      dap.listeners.before.attach.dapui = dapui.open
      dap.listeners.before.launch.dapui = dapui.open
      dap.listeners.before.event_terminated.dapui = dapui.close
      dap.listeners.before.event_exited.dapui = dapui.close
      vim.keymap.set("n", "<leader>dd", dapui.toggle, { desc = "Toggle DAP UI" })
      vim.keymap.set("n", "<leader>dC", function() dapui.open() end, { desc = "Open DAP UI" })
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    opts = {},
  },
}
