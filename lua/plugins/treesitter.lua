return {
  {
    "neovim-treesitter/nvim-treesitter",
    dependencies = { 'neovim-treesitter/treesitter-parser-registry' },
    lazy = false,
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
