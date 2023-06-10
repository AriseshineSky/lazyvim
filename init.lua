vim.g.loaded_netrwPlugin = 1
-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local set = vim.o
set.number = true
set.relativenumber = true
set.clipboard = "unnamed"
-- 设置缩进宽度为 4
set.tabstop = 4
set.shiftwidth = 4

-- 启用自动缩进
set.autoindent = true
set.smartindent = true

-- 使用空格代替制表符进行缩进
set.expandtab = true

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
local n_v = { "n", "v" }
local n_c = { "n", "c" }
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

keymap.set("n", "<Leader><CR>", ":nohlsearch<CR>", opt)
keymap.set("n", "su", ":set nosplitbelow<CR>:split<CR>:set splitbelow<CR>", opt)
keymap.set("n", "sn", ":set nosplitright<CR>:vsplit<CR>:set splitright<CR>", opt)
keymap.set("n", "se", ":set splitbelow<CR>:split<CR>", opt)
keymap.set("n", "si", ":set splitright<CR>:vsplit<CR>", opt)

keymap.set("n", "<Leader>w", "<C-w>w", opt)
keymap.set("n", "<Leader>n", "<C-w>h", opt)
keymap.set("n", "<Leader>u", "<C-w>k", opt)
keymap.set("n", "<Leader>e", "<C-w>j", opt)
keymap.set("n", "<Leader>i", "<C-w>l", opt)

-- Place the two screens up and down
keymap.set("n", "sh", "<C-w>t<C-w>K", opt)
-- Place the two screens side by side
keymap.set("n", "sv", "<C-w>t<C-w>H", opt)

-- Rotate screens
keymap.set("n", "srv", "<C-w>b<C-w>H", opt)
keymap.set("n", "srh", "<C-w>b<C-w>K", opt)

keymap.set("n", "<Leader>t", ":NvimTreeToggle<CR>", opt)

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
        "tpope/vim-endwise"
    },
    {
		"tpope/vim-surround",
	},
    {
		"RRethy/nvim-base16",
		lazy = true,
	},
	{
		"sbdchd/neoformat",
		config = function()
			-- 配置 Neoformat 插件
			vim.g.neoformat_enabled_python = { "black" }
			vim.g.neoformat_enabled_ruby = { "rubocop" }
			-- 添加其他文件类型的自动格式化规则
			vim.api.nvim_set_keymap("n", "<Leader>f", ":Neoformat<CR>", { silent = true })
		end,
	},
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	-- init.lua:
	{
		cmd = "Telescope",
		keys = {
			{ "<C-p>", ":Telescope find_files<CR>", desc = "find files" },
		},
		"nvim-telescope/telescope.nvim",
		tag = "-1.1.1",
		-- or                              , branch = '-1.1.1',
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 99
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({})
		end,
	},
	{ import = "plugins" },
})

vim.cmd.colorscheme("base16-monokai")

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"rust_analyzer",
		"solargraph",
		"yamlls",
		"tsserver",
		"bashls",
		"cssls",
		"html",
		"jsonls",
		"pyright",
	},
})

local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
    vim.keymap.set('n', 'e',     api.node.navigate.sibling.next,        opts('Next Sibling'))
    vim.keymap.set('n', 'u',     api.node.navigate.sibling.prev,        opts('Previous Sibling'))
end

-- pass to setup along with your other options
require("nvim-tree").setup({
	on_attach = my_on_attach,
})
require("indent_blankline").setup({
	-- for example, context is off by default, use this to turn it on
	show_current_context = true,
	show_current_context_start = true,
})
require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "ruby", "html", "css" },

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	-- List of parsers to ignore installing (for "all")
	ignore_install = { "javascript" },

	---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
	-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

	highlight = {
		enable = true,

		-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
		-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
		-- the name of the parser)
		-- list of language that will be disabled
		disable = { "c", "rust" },
		-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
})
-- Lua
keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
)
keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
  {silent = true, noremap = true}
)
keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
  {silent = true, noremap = true}
)
keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
  {silent = true, noremap = true}
)
keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
  {silent = true, noremap = true}
)
local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

local telescope = require("telescope")

telescope.setup {
  defaults = {
    mappings = {
      i = { ["<c-t>"] = trouble.open_with_trouble },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    },
  },
}


vim.api.nvim_command('autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 expandtab')

