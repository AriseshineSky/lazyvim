local set = vim.o
set.number = true
set.relativenumber = true
set.clipboard = "unnamed"
-- 在 copy 后高亮
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	pattern = { "*" },
	callback = function()
		vim.highlight.on_yank({
			timeout = 300,
		})
	end,
})
local opt = { noremap = true, silent = true }
local n_v = {"n", "v"}
local n_c = {"n", "c"}
vim.g.mapleader = " "
local keymap = vim.keymap
local api = vim.api
keymap.set("n", "tu", ":tabe<CR>")

-- 将上下左右键修改为 ueni 键
keymap.set(n_v, "u", "<Up>", opt)
keymap.set(n_v, "e", "<Down>", opt)
keymap.set(n_v, "n", "<Left>", opt)
keymap.set(n_v, "i", "<Right>", opt)
keymap.set(n_v, "U", "5k", opt)
keymap.set(n_v, "E", "5j", opt)

keymap.set(n_v, "k", "i", opt)
keymap.set(n_v, "K", "I", opt)
keymap.set(n_v, "h", "e", opt)
keymap.set(n_v, "S", ":w<CR>", opt)
keymap.set(n_v, "Q", ":q<CR>", opt)
keymap.set(n_v, "I", "$", opt)
keymap.set(n_v, "H", "^", opt)
keymap.set(n_v, "N", "0", opt)

keymap.set("n", "=", "n", opt)
keymap.set("n", "-", "N", opt)
keymap.set("n", "l", "u")

keymap.set("v", "Y", '"+y', opt)
keymap.set("n", "ykw", "yiw", opt)

keymap.set('n', '<Leader><CR>', ':nohlsearch<CR>', opt)
keymap.set('n', 'su', ':set nosplitbelow<CR>:split<CR>:set splitbelow<CR>', opt)
keymap.set('n', 'sn', ':set nosplitright<CR>:vsplit<CR>:set splitright<CR>', opt)
keymap.set('n', 'se', ':set splitbelow<CR>:split<CR>', opt)
keymap.set('n', 'si', ':set splitright<CR>:vsplit<CR>', opt)

keymap.set('n', '<Leader>w', '<C-w>w', opt)
keymap.set('n', '<Leader>n', '<C-w>h', opt)
keymap.set('n', '<Leader>u', '<C-w>k', opt)
keymap.set('n', '<Leader>e', '<C-w>j', opt)
keymap.set('n', '<Leader>i', '<C-w>l', opt)

-- Place the two screens up and down
keymap.set('n', 'sh', '<C-w>t<C-w>K', opt)
-- Place the two screens side by side
keymap.set('n', 'sv', '<C-w>t<C-w>H', opt)

-- Rotate screens
keymap.set('n', 'srv', '<C-w>b<C-w>H', opt)
keymap.set('n', 'srh', '<C-w>b<C-w>K', opt)

-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	{
		"RRethy/nvim-base16",
		lazy = true,
	},
-- init.lua:
    {
	    cmd = "Telescope",
	    keys = {
		    {		    "<C-p>", ":Telescope find_files<CR>", desc = "find files"},
	    },
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
-- or                              , branch = '0.1.1',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
	
})

vim.cmd.colorscheme("base16-tender")
