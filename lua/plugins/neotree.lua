return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    lazy = false, -- neo-tree will lazily load itself
    opts = {
        sources = {
            "filesystem",
            "buffers",
            "git_status",
        },
        enable_git_status = true,
        enable_modified_markers = true,
        close_if_last_window = true,
    },
}

-- ? in buffer for keymaps
