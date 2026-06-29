return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("codecompanion").setup({
        adapters = {
          http = {
            minimax = function()
              local adapter = require("codecompanion.adapters").extend("anthropic", {
                name = "minimax",
                formatted_name = "MiniMax",
                url = "https://api.minimax.io/anthropic/v1/messages",
                env = { api_key = "MINIMAX_API_KEY" },
                schema = {
                  model = {
                    default = "MiniMax-M2.5",
                    choices = {
                      ["MiniMax-M3"]   = { opts = { can_reason = true } },
                      ["MiniMax-M2.5"] = { opts = { can_reason = true } },
                      ["MiniMax-M2.7"] = { opts = { can_reason = true } },
                    },
                  },
                },
              })
              adapter.available_tools = {}
              return adapter
            end,
          },
        },
        display = {
          chat = {
            window = { position = "right", width = 45 },
            diff = { enabled = true },
          },
        },
        strategies = {
          chat = { adapter = "minimax" },
          inline = { adapter = "minimax" },
        },
      })
    end,
    keys = {
      { "<leader>a", "<Cmd>CodeCompanionChat Toggle<CR>", mode = "n", desc = "Toggle AI Chat" },
      { "<leader>A", "<Cmd>CodeCompanion<CR>", mode = { "n", "v" }, desc = "AI Inline Prompt" },
      { "ga", "<Cmd>CodeCompanionChat Add<CR>", mode = "v", desc = "AI: Add selection to chat" },
    },
  },
}
