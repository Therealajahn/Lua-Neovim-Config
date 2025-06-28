vim.g.limelight_conceal_guifg = "#5c3e59"
--Make sure gq doesnt join lines
vim.opt.formatoptions:remove('j')
vim.opt.formatoptions:append('t')
vim.opt.virtualedit = 'all' 
--Remember hidden buffers(tabs aren't erased when not in view)
vim.o.hidden = true
--Adjusts how long to wait for potential next key of a combo
vim.o.timeoutlen = 150 
-- Static line numbers
vim.opt.number = true
-- Set relative line numbers
vim.wo.relativenumber = true;
-- Enable mouse
vim.opt.mouse = 'a'
-- Ignore case for '/' search...
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
--vim.opt.wrap = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
-- Switch to normal mode 
vim.keymap.set({'i','x'}, 'jk', '<Esc>', {desc = 'switch to normal mode'})
-- Remap 'd' to black hole register
vim.keymap.set('n','d','"_d',{ noremap = true })
vim.keymap.set('n','dd','"_dd',{ noremap = true })
-- Copy t-o and paste from system clipboard
vim.keymap.set({'n', 'x'}, 'gy', '"+y')
vim.keymap.set({'n', 'x'}, 'gy', '"+y')
vim.keymap.set({'n', 'x'}, 'gP', '"+P')
vim.keymap.set({'n', 'x'}, 'mm',function()
	vim.cmd('normal! V')
	vim.cmd('normal! "+yy')
	vim.cmd('normal! dd')
	end
)
vim.keymap.set({'n', 'x'}, 'MM',function()
	vim.cmd('normal! "+y')
	vim.cmd('normal! gv')
	vim.cmd('normal! d')
	end
)
vim.keymap.set('n','<Space>j',':w<CR>')
--Save all buffers
vim.keymap.set('n','<Space>jk',':wa<CR>')
--Reset config
vim.keymap.set('n','<Space>jkl',
	function()
		vim.cmd('w')
		vim.cmd('source ' .. vim.env.MYVIMRC)
		vim.cmd('Lazy sync')
	end,
	{ desc= 'Reload init.lua and Lazy.nvim' }
)
--Exit current buffer
vim.keymap.set('n','<Space>h',':q<CR>')
vim.keymap.set('n','<Space>y',':q<CR>:q<CR>')
vim.keymap.set('n','<Space>hn',':q!<CR>')

-- Vertical and Horizontal split
vim.keymap.set('n','E',':vsp<CR>')
vim.keymap.set('n','T',':sp<CR>')
-- Split navigation
vim.keymap.set('n','H','<c-w>h')
vim.keymap.set('n','J','<c-w>j')
vim.keymap.set('n','K','<c-w>k')
vim.keymap.set('n','L','<c-w>l')

-- Split nav to ZenMode
vim.keymap.set('n','fh',':ZenMode<CR><c-w>h:ZenMode<CR>')
vim.keymap.set('n','fj',':ZenMode<CR><c-w>j:ZenMode<CR>')
vim.keymap.set('n','fk',':ZenMode<CR><c-w>k:ZenMode<CR>')
vim.keymap.set('n','fl',':ZenMode<CR><c-w>l:ZenMode<CR>')
-- Split size adjustment
vim.keymap.set('n','<c-h>','<c-w><')
vim.keymap.set('n','<c-l>','<c-w>>')
vim.keymap.set('n','<c-j>','<c-w>+')
vim.keymap.set('n','<c-k>','<c-w>-')
--Panel Movement
vim.keymap.set('n','`h','<c-w>H')
vim.keymap.set('n','`j','<c-w>J')
vim.keymap.set('n','`k','<c-w>K')
vim.keymap.set('n','`l','<c-w>L')
--Tab Stuff
vim.keymap.set('n','gn',':tabnew<CR>')
vim.keymap.set('n','gh','gt')
vim.keymap.set('n','ghj',':ZenMode<CR>gt:ZenMode<CR>')
vim.keymap.set('n','gj','gT')
vim.keymap.set('n','ty',':tabclose<CR>')
--File Navigation toggle
vim.keymap.set('n','-',':Oil<CR>')
vim.keymap.set('n','_',':Oil --float<CR>')
vim.keymap.set('n','OP',':OilCopy')
--Toggle Zenmode
vim.keymap.set('n',',,',':ZenMode<CR><CR>')
--Toggle Limelight
vim.keymap.set('n',';;',':Limelight!!<CR>')
--Paste into commands
vim.keymap.set('c', '<C-p>', '<NOP>', { noremap = true })
vim.keymap.set('c','\\','<c-r>"')
vim.keymap.set('c','<c-p>','<c-r>+')

--Commands to run on file start
vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*",
	callback = function()
    -- Lua code to run on every file open
		vim.cmd('Limelight!!')
  end,
})

--An autocommand for oil
--(switches the directory of the current buffer to the path of oil...)
--(... so that I can do alley oops with both oil and telescope)
vim.api.nvim_create_autocmd("BufEnter",{
	pattern = 'oil://*',
	callback = function()
		local oil = require('oil')
		local dir = oil.get_current_dir()
		if dir then
			vim.cmd('lcd ' .. dir)
		end
	end
})

--Keymaps for Luasnip
local ls = require("luasnip")
vim.keymap.set({"i", "s"}, "fn", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, {silent = true})

vim.keymap.set({"i", "s"}, "fj", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, {silent = true})


 
-- LAZYVIM (plugin manager)
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
---- Install lazy.nvim
--if not vim.loop.fs_stat(lazypath) then
--  print('Installing lazy.nvim....')
--  vim.fn.system({
--    'git',
--    'clone',
--    '--filter=blob:none',
--    'https://github.com',
--    '--branch=stable', -- latest stable release
--    lazypath,
--  })
--end
vim.opt.rtp:prepend(lazypath)  -- Prepend the runtime path for lazy.nvim

-- Lazy.nvim setup to install plugins

require('lazy').setup({
  { 'folke/tokyonight.nvim',
		enabled = true
	},
	{ 'nvim-telescope/telescope.nvim', tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' },
		enabled = true
	},
	{ import = 'plugins/oil' },
	{ "folke/zen-mode.nvim",
		opts = {
			backdrop = 0.5,
			window = {
				width = 90,
			}
		},
		enabled = true
  },
	{ 'junegunn/limelight.vim',
		enabled = true
	},
	{ 'shaunsingh/moonlight.nvim',
		enabled = true
	},
	{
		'maxmx03/fluoromachine.nvim',
		lazy = false,
		priority = 1000,
		config = function ()
		 local fm = require 'fluoromachine'

		 fm.setup {
				glow = false,
				theme = 'fluoromachine',
				transparent = true,
		 }
		end
	},
	{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			config = function () 
				local configs = require("nvim-treesitter.configs")

				configs.setup({
						ensure_installed = 
						{ "c", "lua", "vim", "vimdoc",
						"query", "elixir", "heex", "javascript", "html" },
						sync_install = true,
						highlight = { enable = true },
						indent = { enable = true }, })
			end,
		enabled = true
	 },
	{ 
		'olivercederborg/poimandres.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			require('poimandres').setup {
				-- leave this setup function empty for default config
				-- or refer to the configuration section
				-- for configuration options
			}
		end,
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' }
	},
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
	},
	{
		'barrett-ruth/live-server.nvim',
		build = 'pnpm add -g live-server',
		cmd = { 'LiveServerStart', 'LiveServerStop' },
		config = true
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",           
			"saadparwaiz1/cmp_luasnip",   
			"hrsh7th/cmp-path",            
			"hrsh7th/cmp-nvim-lsp",        
			"hrsh7th/cmp-buffer", 
		},
	},
	{ 'neovim/nvim-lspconfig' },
	{
		"icholy/lsplinks.nvim",
		config = function()
				local lsplinks = require("lsplinks")
				lsplinks.setup()
				vim.keymap.set("n", "gx", lsplinks.gx)
		end
	},
	{ 'vimwiki/vimwiki' },
	{ 'jbyuki/venn.nvim' },
	{
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("null-ls").setup()
    end,
	},
	{
  "allaman/emoji.nvim",
  version = "1.0.0", -- optionally pin to a tag
  ft = "markdown", -- adjust to your needs
  dependencies = {
    -- util for handling paths
    "nvim-lua/plenary.nvim",
    -- optional for nvim-cmp integration
    "hrsh7th/nvim-cmp",
    -- optional for telescope integration
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    -- default is false, also needed for blink.cmp integration!
    enable_cmp_integration = true,
    -- is not vim.fn.stdpath("data") .. "/lazy/
    -- plugin_path = vim.fn.expand("$HOME/plugins/"),
  },
  config = function(_, opts)
    require("emoji").setup(opts)
    -- optional for telescope integration
    local ts = require('telescope').load_extension 'emoji'
    vim.keymap.set('n', '<leader>se', ts.emoji, { desc = '[S]earch [E]moji' })
  end,
}
	--newplugin
})

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "javascript","tsx" }, -- Ensure JavaScript is installed
  highlight = {
    enable = true,          -- Enable Treesitter for syntax highlighting
    additional_vim_regex_highlighting = false, -- Disable standard syntax for better Treesitter performance
  },
}

--/////THEMES///////////////////////////////////////////////////////////
vim.opt.termguicolors = true
-- Apply tokyonight theme
--vim.cmd.colorscheme('tokyonight')
vim.cmd.colorscheme('fluoromachine')
--vim.cmd.colorscheme('moonlight')
--vim.cmd.colorscheme('poimandres')
-- Apply moonlight theme
--require('moonlight').set()

--Start Lualine
require('lualine').setup()

--Install VScode snippets 
require("luasnip.loaders.from_vscode").lazy_load()
--Enable 
vim.cmd([[
  autocmd FileType lua,javascript,markdown,text,gitcommit setlocal spell
]])
--CMD Settings
--TODO: install some lsp language servers and get it working with cmp
--(to check if working use :CmpStatus command
--local lspconfig = require('lspconfig')
--lspconfig.ts_ls.setup({})

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },  		
		
  mapping = {
    ["<j'>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),  -- Confirm selection
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },  -- LuaSnip source
    { name = "buffer" },
    { name = "path" },                 
		{ name = "emoji" },
  },                                   
})                                     
                                 
-- venn.nvim: enable or disable keymappings
        -- draw a line on HJKL keystokes
        vim.keymap.set("v", "<Down>", "j:VBox<CR>v", {noremap = true})
        vim.keymap.set("v", "<Up>", "k:VBox<CR>v", {noremap = true})
        vim.keymap.set("v", "<Right>", "l:VBox<CR>v", {noremap = true})
        vim.keymap.set("v", "<Left>", "h:VBox<CR>v", {noremap = true})
        -- draw a box by pressing "f with visual selection
        vim.keymap.set("v", "f", ":VBox<CR>", {noremap = true})

-- toggle keymappings for venn using <leader>v
vim.api.nvim_set_keymap('n', '<leader>v', ":lua Toggle_venn()<CR>", { noremap = true})
--Telescope settings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

--Null/Prettier settings
local null_ls = require("null-ls")
null_ls.setup({
 null_ls.builtins.formatting.prettier.with({
            filetypes = { "lua","javascript", "javascriptreact", "typescript", "typescriptreact", "json", "html", "css", "yaml", "markdown" },
        }),
})
	--format with Prettier on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
require("null-ls").setup({
    sources = {
        null_ls.builtins.formatting.prettier,
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
})
