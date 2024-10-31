-- Static line numbers

vim.opt.number = true
-- Set relative line numbers
vim.wo.relativenumber = true
-- Enable mouse
vim.opt.mouse = 'a'


-- Ignore case for '/' search...
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.wrap = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
-- Switch to normal mode with jk
vim.keymap.set({'i','x'}, 'jk', '<Esc>', {desc = 'switch to normal mode'})
-- Change indent(conflict with surround)
vim.keymap.set('x','7','<')
vim.keymap.set('x','8','>')
-- Copy t-o and paste from system clipboard
vim.keymap.set({'n', 'x'}, 'gy', '"+y')
vim.keymap.set({'n', 'x'}, 'gp', '"+p')
--Save current buffer
vim.keymap.set('n','<Space>j',':w<CR>')
--Save all buffers
vim.keymap.set('n','<Space>jk',':wa<CR>')
--Reset config
vim.keymap.set('n','<Space>jk',
	function()
		vim.cmd('source ' .. vim.env.MYVIMRC)
		vim.cmd('Lazy sync')
	end,
	{ desc= 'Reload init.lua and Lazy.nvim' }
)

--Exit current buffer
vim.keymap.set('n','<Space>h',':q<CR>')

-- Vertical and Horizontal split
vim.keymap.set('n','E',':vsp<CR>')
vim.keymap.set('n','T',':sp<CR>')
-- Split navigation
vim.keymap.set('n','H','<c-w>h')
vim.keymap.set('n','J','<c-w>j')
vim.keymap.set('n','K','<c-w>k')
vim.keymap.set('n','L','<c-w>l')
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
vim.keymap.set('n','gy','gT')
vim.keymap.set('n','ty',':tabclose<CR>')
--File Navigation toggle
vim.keymap.set('n','OU',':Oil<CR>')
vim.keymap.set('n','<c-ou>',':Oil --float<CR>')
--Toggle Zenmode
vim.keymap.set('n','qq',':ZenMode<CR>')
--Toggle Limelight
vim.keymap.set('n','mm',':Limelight!!<CR>')

--Commands to run on file start
vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*",
	callback = function()
    -- Lua code to run on every file open
		vim.cmd(':Limelight')
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

-- LAZYVIM (plugin manager)
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  print('Installing lazy.nvim....')
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)  -- Prepend the runtime path for lazy.nvim

-- Function to load all plugin configuration files from lua/plugins/
local function load_plugins()
  local plugins = {}

  -- Get all Lua files in the plugins directory
  local plugin_files = vim.fn.glob(vim.fn.stdpath("config") .. "/lua/plugins/*.lua", true, true)

  -- Loop through each plugin file and require it
  for _, file in ipairs(plugin_files) do
    local plugin_name = file:match("lua/plugins/(.*)%.lua$")
    local plugin_config = require("plugins." .. plugin_name)

    -- Add plugin configuration to the plugins table
    vim.list_extend(plugins, plugin_config)
  end

  return plugins
end

-- Lazy.nvim setup to install plugins

-- Plugin configurations
require('lazy').setup({
	load_plugins(),
  {'folke/tokyonight.nvim'},
  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      'rafamadriz/friendly-snippets', -- Collection of snippets including React
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
	{
	'nvim-telescope/telescope.nvim', tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{ import = 'plugins/oil' },
	{ "folke/zen-mode.nvim",
		opts = {
			backdrop = 0.5,
			window = {
				width = 90,
			}
	}	
  },
	{ 'junegunn/limelight.vim' },
	{ 'shaunsingh/moonlight.nvim' },
	{ 'feline-nvim/feline.nvim' },
	{ 'nvim-tree/nvim-web-devicons' },
	{
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
},
{
    "NStefan002/visual-surround.nvim",
    config = function()
        require("visual-surround").setup({
            -- your config
        })
    end,
    -- or if you don't want to change defaults
    -- config = true
},
{ 'metakirby5/codi.vim' },
})


--/////THEMES///////////////////////////////////////////////////////////
vim.opt.termguicolors = true
-- Apply tokyonight theme
--vim.cmd.colorscheme('tokyonight')
-- Apply moonlight theme
require('moonlight').set()
require('feline').setup() 



--Telescope settings
local builtin = require('telescope.builtin')
vim.keymap.set('n', 'ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

