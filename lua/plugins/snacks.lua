return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile      = { enabled = true },
      dashboard    = {
        enabled = true,
        preset = {
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "g", desc = "Git", action = ":lua Snacks.lazygit()" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
          header = [[
███████╗███████╗███████╗███████╗ █████╗ 
╚══███╔╝██╔════╝╚════██║╚════██║██╔══██╗
  ███╔╝ █████╗      ██╔╝    ██╔╝███████║
 ███╔╝  ██╔══╝     ██╔╝    ██╔╝ ██╔══██║
███████╗███████╗   ██║     ██║  ██║  ██║
╚══════╝╚══════╝   ╚═╝     ╚═╝  ╚═╝  ╚═╝]],
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
          {
            pane = 2,
            section = "terminal",
            cmd = "cat " .. vim.fn.stdpath("config") .. "/static/ze77a.txt",
            height = 35,
            ttl = 86400,
            hl = "header",
            indent = 2,
          },
          { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        },
      },
      explorer     = { enabled = true },
      indent       = { enabled = true },
      input        = { enabled = true },
      picker       = {
        enabled = true,
        sources = {
          explorer = {
            win = {
              list = {
                keys = {
                  ["n"] = "explorer_add",
                },
              },
            },
          },
        },
        layouts = {
          top_right_search = {
            layout = {
              backdrop = false,
              width = 0.35,
              height = 0.45,
              row = 1,
              position = "right",
              border = "rounded",
              title = " {title} {live} {flags}",
              title_pos = "center",
              box = "vertical",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
              { win = "preview", title = "{preview}", height = 0.4, border = "top" },
            },
          },
        },
      },
      notifier     = {
        enabled = true,
        style = "fancy",
        timeout = 3000,
        top_down = false,
      },
      quickfile    = { enabled = true },
      scope        = { enabled = true },
      scroll       = {
        enabled = true,
        animate = {
          duration = { step = 10, total = 200 },
        },
        animate_repeat = {
          delay = 100,
          duration = { step = 5, total = 50 },
        },
      },
      statuscolumn = { enabled = true },
      words        = { enabled = true },
      terminal     = { enabled = true },
    },
    keys = {
      { "<leader>nt", function() Snacks.explorer.open() end, desc = "Explorador de archivos" },
      { "<leader>cc", function() Snacks.terminal.open() end, desc = "Terminal" },
      { "<leader>w", "<Cmd>w<CR>", desc = "Guardar" },
      { "<leader>q", function()
        local bufnr = vim.api.nvim_get_current_buf()
        local listed = vim.iter(vim.api.nvim_list_bufs()):filter(function(b)
          return vim.fn.buflisted(b) == 1
        end):totable()
        local real = vim.iter(listed):filter(function(b)
          return vim.api.nvim_buf_get_name(b) ~= ""
        end):totable()
        if #real == 0 then
          if vim.g.ze_no_real_buffers then
            vim.cmd("qa")
            return
          end
          vim.g.ze_no_real_buffers = true
          Snacks.explorer.open()
          return
        end
        vim.g.ze_no_real_buffers = false
        if vim.api.nvim_buf_is_valid(bufnr) then
          pcall(vim.api.nvim_buf_delete, bufnr, { force = false })
        end
        listed = vim.iter(vim.api.nvim_list_bufs()):filter(function(b)
          return vim.fn.buflisted(b) == 1
        end):totable()
        real = vim.iter(listed):filter(function(b)
          return vim.api.nvim_buf_get_name(b) ~= ""
        end):totable()
        if #real == 0 then
          vim.g.ze_no_real_buffers = true
          Snacks.explorer.open()
        end
      end, desc = "Cerrar buffer" },
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Buscar archivos" },
      { "<leader>gg", function() Snacks.lazygit() end, desc = "LazyGit" },
      { "<C-f>", function()
        Snacks.picker.grep({
          layout = { preset = "top_right_search" },
        })
      end, desc = "Buscar en archivos" },
    },
  },
}
