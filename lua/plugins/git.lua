return {
    {
        "lewis6991/gitsigns.nvim",
        enabled = vim.fn.executable "git" == 1,
        event = "VeryLazy",
        -- ft = "gitcommit",
        keys = {
            -- GitSigns
            {"]g", "", callback = function() require("gitsigns").next_hunk() end, desc = "Next Git hunk" },
            {"[g", "", callback = function() require("gitsigns").prev_hunk() end, desc = "Previous Git hunk" },
            {"<leader>gl", "", callback = function() require("gitsigns").blame_line() end, desc = "View Git blame" },
            {"<leader>gL", "", callback = function() require("gitsigns").blame_line { full = true } end, desc = "View full Git blame" },
            {"<leader>gp", "", callback = function() require("gitsigns").preview_hunk() end, desc = "Preview Git hunk" },
            {"<leader>gh", "", callback = function() require("gitsigns").reset_hunk() end, desc = "Reset Git hunk" },
            {"<leader>gr", "", callback = function() require("gitsigns").reset_buffer() end, desc = "Reset Git buffer" },
            {"<leader>gs", "", callback = function() require("gitsigns").stage_hunk() end, desc = "Stage Git hunk" },
            {"<leader>gS", "", callback = function() require("gitsigns").stage_buffer() end, desc = "Stage Git buffer" },
            {"<leader>gu", "", callback = function() require("gitsigns").undo_stage_hunk() end, desc = "Unstage Git hunk" },
            -- {"<leader>gd", "", callback = function() require("gitsigns").diffthis() end, desc = "View Git diff" },
        },
        opts = {
            signcolumn = true,
            signs = {
                add = {
                    text = "▎",
                },
                change = {
                    text = "▎",
                },
                delete = {
                    text = "▁",
                },
                topdelete = {
                    text = "▔",
                },
                changedelete = {
                    text = "▎",
                },
                untracked = {
                    text = "▎",
                },
            },
        },
    },
}
