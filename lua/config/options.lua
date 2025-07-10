-- Relative line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Hide statusbar
vim.o.showmode = false

-- Case-insensiteive searching unless \C or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Fixing tab spacing
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Storing undos between sessions
vim.opt.undofile = true

-- Sign Column (Code varnings and errors)
vim.opt.signcolumn = "yes"

-- Minimal numver of screen lines to keep above and below the cursor
vim.opt.scrolloff = 10
