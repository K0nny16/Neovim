return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        -- Config comes here
        -- Empty == default settings
        --
    },
    keys = {
        {
            "<leader?>",
            function()
                require("which-key").show({ global = false})
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
