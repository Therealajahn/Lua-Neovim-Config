--Remember hidden buffers
vim.o.hidden = true
--Adjusts how long to wait for potential next key of a combo
vim.o.timeoutlen = 150
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
vim.keymap.set('n','<Space>hn',':q!<CR>')

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
vim.keymap.set('n','ghj',':ZenMode<CR><CR>gt:ZenMode<CR><CR>')
vim.keymap.set('n','gy','gT')
vim.keymap.set('n','ty',':tabclose<CR>')
--File Navigation toggle
vim.keymap.set('n','OU',':Oil<CR>')
vim.keymap.set('n','<c-ou>',':Oil --float<CR>')
--Toggle Zenmode
vim.keymap.set('n','qq',':ZenMode<CR><CR>')
--Toggle Limelight
vim.keymap.set('n','mm',':Limelight!!<CR>')

--Commands to run on file start
vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*",
	callback = function()
    -- Lua code to run on every file open
		vim.cmd(':Limelight!!')
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
  { 'folke/tokyonight.nvim'},
	{ 'nvim-telescope/telescope.nvim', tag = '0.1.8',
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
})


--/////THEMES///////////////////////////////////////////////////////////
vim.opt.termguicolors = true
-- Apply tokyonight theme
--vim.cmd.colorscheme('tokyonight')
-- Apply moonlight theme
require('moonlight').set()



--Telescope settings
local builtin = require('telescope.builtin')
vim.keymap.set('n', 'ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', 'fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', 'fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', 'fh', builtin.help_tags, { desc = 'Telescope help tags' })
