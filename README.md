# My Neovim Configuration

This repository contains my personal Neovim configuration written in **Lua**.  
It is built with **Lazy.nvim** as the plugin manager and focuses on productivity, keyboard-driven workflows, and tools for coding, writing, and live coding music.

---

## ✨ Features

- **Editing & Navigation**
  - Relative line numbers + mouse support.
  - Fast escape from insert/visual with `jk`.
  - Blackhole register for deletes (`d`, `dd`) to avoid overwriting clipboard.
  - System clipboard integration (`gy`, `gp`, `mm`, `MM`).
  - File navigation with **Oil.nvim** (`-` for split, `_` for float).
  - Split and tab management with intuitive keymaps.
  - ZenMode (`,,`) and Limelight (`;;`) toggles for focused writing.

- **Productivity**
  - Auto-save shortcuts (`<space>j`, `<space>jk`).
  - Quick quit commands (`<space>h`, `<space>y`, `<space>hn`).
  - Telescope integration for file/buffer/search.
  - Prettier formatting on save via **null-ls**.

- **Plugins**
  - [Lazy.nvim](https://github.com/folke/lazy.nvim) (plugin manager).
  - [Oil.nvim](https://github.com/stevearc/oil.nvim) for file navigation.
  - [ZenMode](https://github.com/folke/zen-mode.nvim) + [Limelight](https://github.com/junegunn/limelight.vim).
  - [Telescope](https://github.com/nvim-telescope/telescope.nvim).
  - [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for highlighting/indentation.
  - [LuaSnip](https://github.com/L3MON4D3/LuaSnip) with VSCode snippets.
  - [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) for completion.
  - [Strudel.nvim](https://github.com/gruvw/strudel.nvim) for live coding.
  - [tidalcycles/vim-tidal](https://github.com/tidalcycles/vim-tidal) for TidalCycles integration.
  - Additional plugins: Vimwiki, Lualine, Emojis, Emmet, venn.nvim, Live Server, Null-ls.

- **Theming**
  - Colorschemes: Tokyonight, Moonlight, Fluoromachine, Poimandres.
  - `termguicolors` enabled for full-color support.
  - Lualine configured for a modern statusline.

- **Language Support**
  - Treesitter for JavaScript, TypeScript, Lua, HTML, CSS, Elixir, etc.
  - LSP integration with cmp and null-ls.
  - Emmet LSP for frontend development.

- **Creative Coding**
  - Strudel and TidalCycles support for algorithmic music.
  - Custom keymaps for launching, toggling, and updating Strudel sessions.

---

## 🚀 Installation

1. Install [Neovim 0.9+](https://neovim.io/).
2. Clone this repository into your config folder:
   ```bash
   git clone https://github.com/yourusername/nvim ~/.config/nvim
