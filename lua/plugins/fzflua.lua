return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
    keys={
        {
            "<leader>ff",
            function() require('fzf-lua').files() end,
            desc="Find files in current project directory"
        },
        {
            "<leader>fg",
            function() require('fzf-lua').live_grep() end,
            desc="Find by grepping current project directory"
        },
        {
            "<leaderfb",
            function() require('fzf-lua').builtin() end,
            desc="Find diffrent builtin functions for fzf"
        },
        {
            "<leader>fh",
            function() require('fzf-lua').helptags() end,
            desc="Finds in the Neovim help"
        },
        {
            "<leader>fk",
            function() require('fzf-lua').keymaps() end,
            desc="Finds keybindings"
        },
        {
            "<leader>fw",
            function() require('fzf-lua').grep_cword() end,
            desc="Finds a specific word"
        },
        {
            "<leader>fr",
            function() require('fzf-lua').resume() end,
            desc="Resumes the previous search"
        },
        {
            "<leader>fd",
            function() require('fzf-lua').diagnostics_document() end,
            desc="Find in the diagnostics"
        },
        {
            "<leader><leader>",
            function() require('fzf-lua').buffers() end,
            desc="Search the open buffers"
        },
        {
            "<leader>/",
            function() require('fzf-lua').lgrep_curbuf() end,
            desc="Live grep the current buffer"
        },
    }
}
