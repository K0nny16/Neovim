-- Setting leaderkey
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Clear highlights
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Neotree toggle
vim.keymap.set('n', '-', '<Cmd>Neotree toggle<CR>')

-- Diagnostics Keybind
vim.keymap.set('n', 'gl', function() vim.diagnostic.open_float() end,
    { desc = "Open diagnostics in float" }
)

-- Code formatting. Using the set formatters and falling back on LSP.
vim.keymap.set('n', '<leader>cf', function()
        require('conform').format({
            lsp_format = "fallback",
        })
    end,
    { desc = "Format current file" })
