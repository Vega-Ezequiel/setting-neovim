return {
  -- 1) Mason: gestor de binarios LSP
  {
    "williamboman/mason.nvim",
    lazy = false,
    opts = {},
  },

  -- 2) Auto-instalacion de servers JS/TS full via mason
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    opts = {
      ensure_installed = {
        "typescript-language-server",
        "eslint",
        "prettierd",
        "html-lsp",
        "css-lsp",
        "json-lsp",
        "lua-language-server",
      },
      automatic_install = false,
      run_on_start = false,
      start_delay = 5000,
    },
  },

  -- 3) lspconfig: provee configs (lsp/<name>.lua) usadas por vim.lsp.enable
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      local group = vim.api.nvim_create_augroup("lsp_attach", { clear = true })

      local function snacks_picker(name, opts)
        return function()
          if Snacks and Snacks.picker and Snacks.picker[name] then
            Snacks.picker[name](opts)
          else
            vim.notify("Snacks.picker." .. name .. " no disponible", vim.log.levels.WARN)
          end
        end
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = group,
        callback = function(ev)
          local bufnr = ev.buf
          local function map(mode, lhs, rhs, desc)
            if type(rhs) ~= "string" and type(rhs) ~= "function" then
              return
            end
            vim.keymap.set(mode, lhs, rhs, {
              buffer = bufnr,
              silent = true,
              desc = desc,
            })
          end

          map("n", "gd", snacks_picker("lsp_definitions"), "Goto Definition")
          map("n", "gD", snacks_picker("lsp_declarations"), "Goto Declaration")
          map("n", "gr", snacks_picker("lsp_references", { include_current = true }), "References")
          map("n", "gI", snacks_picker("lsp_implementations"), "Goto Implementation")
          map("n", "gy", snacks_picker("lsp_type_definitions"), "Goto Type Definition")
          map("n", "K",  function() vim.lsp.buf.hover() end, "LSP Hover")
          map("n", "<leader>rn", function()
            if Snacks and Snacks.rename and Snacks.rename.rename_file then
              Snacks.rename.rename_file()
            else
              vim.lsp.buf.rename()
            end
          end, "Rename symbol/file")
          map({ "n", "v" }, "<leader>ca", function() vim.lsp.buf.codeaction() end, "Code Action")
          map("n", "<leader>lf", function() vim.diagnostic.open_float({ border = "rounded" }) end, "Line Diagnostics")
          map("n", "<leader>ld", function() Snacks.picker.diagnostics_buffer() end, "Buffer Diagnostics")
        end,
      })

      vim.lsp.config('ts_ls', {
        filetypes = {
          'javascript', 'javascriptreact', 'javascript.jsx',
          'typescript', 'typescriptreact', 'typescript.tsx',
        },
      })

      vim.lsp.config('eslint', {
        filetypes = {
          'javascript', 'javascriptreact', 'typescript',
          'typescriptreact', 'vue', 'html', 'svelte',
        },
        settings = {
          validate = 'on',
          packageManager = nil,
          format = false,
          quiet = false,
        },
      })

      vim.lsp.config('html', {})

      vim.lsp.config('cssls', {
        settings = {
          css = { validate = true },
          scss = { validate = true },
          less = { validate = true },
        },
      })

      vim.lsp.config('jsonls', {})

      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })

      vim.lsp.enable('ts_ls')
      vim.lsp.enable('eslint')
      vim.lsp.enable('html')
      vim.lsp.enable('cssls')
      vim.lsp.enable('jsonls')
      vim.lsp.enable('lua_ls')
    end,
  },
}
