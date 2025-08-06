return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "buffers" },
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "find" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "grep" },
        { "<leader>fp", "<cmd>Telescope git_files<cr>", desc = "find in git" },
        { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "help" },
        { "<leader>sk", "<cmd>Telescope help_tags<cr>", desc = "keymaps" },
    },
}
