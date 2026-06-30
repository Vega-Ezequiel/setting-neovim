return {
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {
      enable_close_on_slash = false,
      enable_rename = true,
      enable_close_on_delete = true,
      enable_inline_spell = false,
      html = {
        enable = true,
        block_default = { "div", "p", "span", "li", "ul", "ol", "table", "tr", "td", "th" },
      },
      javascript = {
        enable = true,
        block_default = { "div", "span", "p" },
      },
      typescript = {
        enable = true,
        block_default = { "div", "span", "p" },
      },
      tsx = {
        enable = true,
        block_default = { "div", "span", "p" },
      },
      jsx = {
        enable = true,
        block_default = { "div", "span", "p" },
      },
      vue = {
        enable = true,
        block_default = { "div", "p", "span", "li", "ul", "ol" },
      },
      svelte = {
        enable = true,
        block_default = { "div", "p", "span", "li", "ul", "ol" },
      },
      close_template = {
        html = { "<%s> ", "</%s>" },
        vue  = { "<%s>", "</%s>" },
        tsx  = { "<%s>", "</%s>" },
        jsx  = { "<%s>", "</%s>" },
        javascript = { "<%s>", "</%s>" },
        typescript = { "<%s>", "</%s>" },
      },
    },
  },
}
