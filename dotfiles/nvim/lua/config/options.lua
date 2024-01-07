vim.g.mapleader = " "
vim.g.maplocalleader = " "

if vim.g.neovide then
  vim.g.neovide_cursor_trail_legnth = 0
  vim.g.neovide_cursor_animation_length = 0
end

local opt = vim.opt

-- TODO Look into the following options:
-- https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/plugin/options.lua

opt.relativenumber = true
opt.number = true
opt.mouse = 'a'
opt.showmatch = true
opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.scrolloff = 10
opt.history = 1000

opt.colorcolumn = '80'
-- Doesn't currently work for whatever reason. Maybe related to some kickstart.nvim stuff I have added.
--opt.smoothscroll = true

opt.laststatus = 2

opt.autoindent = true
opt.breakindent = true

opt.clipboard = 'unnamedplus'

opt.undofile = true

opt.signcolumn = 'yes'

opt.completeopt = 'menuone,noselect'

opt.termguicolors = true

opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4

opt.updatetime = 1000
