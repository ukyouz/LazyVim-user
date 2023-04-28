-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local H = require "utils.helper"

vim.opt.autoindent=true
vim.opt.autoread=true
vim.opt.cursorline=true
-- vim.opt.clipboard+=unnamedplus
vim.opt.expandtab=true
vim.opt.fixendofline=false
vim.opt.formatoptions="qj" -- -=tc
if H.is_windows() then
    vim.opt.guifont = "JetBrainsMono Nerd Font Mono:h9:w70"
else
    vim.opt.guifont = "FiraCode Nerd Font Mono:h14"
end
vim.opt.hlsearch=true
vim.opt.incsearch=true
-- vim.opt.lazyredraw=true
vim.opt.linespace=2
vim.opt.list=true
-- vim.opt.listchars=tab:\┊\ ,trail:·,extends:?,precedes:?,nbsp:×
vim.opt.mouse="a"
vim.opt.number=true
-- vim.opt.path+=**
vim.opt.scrolloff=0
vim.opt.shiftwidth=4
vim.opt.shortmess="filnxtToOFat"  -- += at
vim.opt.signcolumn="yes"
vim.opt.softtabstop=4
vim.opt.splitbelow=true
vim.opt.splitright=true
vim.opt.tabstop=4
vim.opt.title=true
vim.opt.titlestring = "%{getcwd()} - NVIM"
vim.opt.updatetime=200
vim.opt.wrap=false
vim.opt.wrapscan=false

-- Turn backup off
vim.opt.backup=false
vim.opt.wb=false
vim.opt.swapfile=false
vim.opt.hidden=true

