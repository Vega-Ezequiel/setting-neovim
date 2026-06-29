return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "lua", "vim", "vimdoc", "query", "json", "bash", "python",
        "c", "css", "html", "javascript", "markdown", "markdown_inline",
        "scss", "typescript", "tsx", "vue", "yaml", "toml",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}
