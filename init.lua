vim.g.mapleader = " "        -- espacio = tu tecla líder (para atajos <space>...)
vim.g.maplocalleader = " "   -- para atajos cuando hay un buffer específico
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true  -- colores reales en la terminal

-- =========================================
-- 0. Agregar PATHs locales
-- =========================================
vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.expand("~/.local/go/bin")
vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.expand("~/go/bin")
vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.expand("~/.local/bin")

-- =========================================
-- 1. Highlight groups — paleta verde para dashboard
-- =========================================
vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = "#00ff00", bold = true })
vim.api.nvim_set_hl(0, "SnacksDashboardKey",    { fg = "#00cc00" })
vim.api.nvim_set_hl(0, "SnacksDashboardDesc",   { fg = "#88ff88" })
vim.api.nvim_set_hl(0, "SnacksDashboardIcon",   { fg = "#00ff00" })
vim.api.nvim_set_hl(0, "SnacksDashboardDir",    { fg = "#66ff66" })
vim.api.nvim_set_hl(0, "SnacksDashboardFile",   { fg = "#aaffaa" })
vim.api.nvim_set_hl(0, "SnacksDashboardFooter", { fg = "#55aa55" })

-- =========================================
-- 2. Keymaps globales sin plugin
-- =========================================
vim.keymap.set('i', 'ii', '<Esc>', { desc = "Salir de insert mode con doble i" })

-- =========================================
-- 3. Instalar lazy.nvim si no existe
-- =========================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- =========================================
-- 4. Cargar todos los plugins de lua/plugins/
-- =========================================
require("lazy").setup("plugins")
