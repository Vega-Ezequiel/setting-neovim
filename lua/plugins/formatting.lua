return {
  {
    "stevearc/conform.nvim",
    lazy = false,
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>fm",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        desc = "Format buffer",
        mode = { "n", "v" },
      },
    },
    event = { "BufWritePre" },
    config = function()
      local conform = require("conform")

      conform.setup({
        notify_on_error = false,
        formatters_by_ft = {
          -- IMPORTANTE: prettier PRIMERO, eslint_d DESPUES
          ["javascript"]        = { "prettier", "eslint_d" },
          ["javascriptreact"]   = { "prettier", "eslint_d" },
          ["typescript"]        = { "prettier", "eslint_d" },
          ["typescriptreact"]   = { "prettier", "eslint_d" },
          ["vue"]               = { "prettier", "eslint_d" },
          ["svelte"]            = { "prettier", "eslint_d" },
          ["css"]               = { "prettier" },
          ["scss"]              = { "prettier" },
          ["less"]              = { "prettier" },
          ["html"]              = { "prettier" },
          ["json"]              = { "prettier" },
          ["jsonc"]             = { "prettier" },
          ["markdown"]          = { "prettier" },
          ["yaml"]              = { "prettier" },
        },
        formatters = {
          prettier = {
            prepend_args = { "--single-quote", "false" },
          },
          eslint_d = {
            prepend_args = {
              "--fix",
              "--fix-type",
              "problem,suggestion,layout",
            },
          },
        },
        format_on_save = function(bufnr)
          local disable_autoformat = false
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            disable_autoformat = true
          end
          return {
            timeout_ms = 500,
            cancel_on_timeout = false,
            lsp_fallback = not disable_autoformat,
          }
        end,
      })
    end,
  },
}
