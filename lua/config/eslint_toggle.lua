-- Toggle ESLint in null-ls
local eslint_enabled = true
local null_ls = require("null-ls")

function ToggleEslintNullLs()
  if eslint_enabled then
    -- Disable ESLint diagnostics
    null_ls.disable({ name = "eslint" })
    print("ESLint null-ls disabled")
    eslint_enabled = false
  else
    -- Enable ESLint diagnostics
    null_ls.enable({ name = "eslint" })
    print("ESLint null-ls enabled")
    eslint_enabled = true
  end
end

-- Key mapping to toggle ESLint
vim.keymap.set('n', '<leader>te', ToggleEslintNullLs, {desc = 'Toggle ESLint in null-ls'})
