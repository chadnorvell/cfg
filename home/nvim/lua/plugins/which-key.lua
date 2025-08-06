return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        spec = {
            { "<leader>b", group = "buffers" },
            { "<leader>c", group = "code" },
            { "<leader>g", group = "git" },
            { "<leader>s", group = "search" },
            { "<leader>t", group = "tabs" },
            { "<leader>x", group = "diagnostics" },

            { "<leader>f", group = "files" },
            { "<leader>fs", vim.cmd.w, desc = "save" },

            { "<leader>q", group = "quit" },
            { "<leader>qa", vim.cmd.qa, desc = "all" },

            { "<leader>u", group = "ui" },
            { "<leader>uc", group = "color scheme" },

            { "<leader>H", vim.cmd.noh, desc = "clear highlight" }
        },
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "which key",
        },
        {
            "<leader>w",
            function()
                require("which-key").show({ keys = "<c-w>", loop = true })
            end,
            desc = "windows",
        },
    },
}
