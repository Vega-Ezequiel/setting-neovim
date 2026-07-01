return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
    dependencies = {
      {
        "saghen/blink.lib",
        version = "1.*",
      },
      "rafamadriz/friendly-snippets",
    },
    opts = {
      keymap = {
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"]     = { "hide", "fallback" },
        ["<C-d>"]     = { "scroll_documentation_down", "fallback" },
        ["<C-u>"]     = { "scroll_documentation_up", "fallback" },
        ["<C-n>"]     = { "select_next", "fallback" },
        ["<C-p>"]     = { "select_prev", "fallback" },
        ["<CR>"]      = { "accept", "fallback" },
        ["<Tab>"]     = { "snippet_forward", "fallback" },
        ["<S-Tab>"]   = { "snippet_backward", "fallback" },
        ["<Up>"]      = { "select_prev", "fallback" },
        ["<Down>"]    = { "select_next", "fallback" },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          lsp = {
            name = "LSP",
            module = "blink.cmp.sources.lsp",
            enabled = true,
          },
          path = {
            name = "Path",
            module = "blink.cmp.sources.path",
            enabled = true,
            score_offset = 0,
          },
          snippets = {
            name = "Snippets",
            module = "blink.cmp.sources.snippet",
            enabled = true,
          },
          buffer = {
            name = "Buffer",
            module = "blink.cmp.sources.buffer",
            enabled = true,
            score_offset = -2,
            min_keyword_size = 2,
          },
        },
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            max_height = 20,
            max_width = 60,
          },
        },
        menu = {
          max_height = 12,
          border = "rounded",
          draw = {
            columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
          },
        },
      },
      snippets = {
        expand = function(args)
          require("blink.cmp.lib").show_snippet_preview(args)
        end,
      },
      fuzzy = {
        implementation = "prefer_rust",
      },
      appearance = {
        nerd_font_variant = "mono",
      },
    },
  },
}
