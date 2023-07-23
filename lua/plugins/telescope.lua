local H = require "utils.helper"

return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        enabled = function()
            return vim.version().minor >= 9
        end,
        keys = {
            {
                "<leader>tf", "<cmd>:Telescope find_files<cr>",
                desc = "Find Files",
            },
            {
                "<leader>tg", "<cmd>:Telescope live_grep<cr>",
                desc = "Live Grep",
            },
            {
                "<leader>tb", "<cmd>:Telescope buffers<cr>",
                desc = "Find Buffers",
            },
            {
                "<leader>th", "<cmd>:Telescope help_tags<cr>",
                desc = "Find Helps",
            },
        },
        opts = {
            extensions = {
                fzf = {
                    fuzzy = true,                    -- false will only do exact matching
                    override_generic_sorter = true,  -- override the generic sorter
                    override_file_sorter = true,     -- override the file sorter
                    case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                                    -- the default case_mode is "smart_case"
                }
            }
        },
    },
    -- {
    --     "nvim-telescope/telescope-fzf-native.nvim",
    --     event = "VeryLazy",
    --     dependencies = {
    --         "nvim-telescope/telescope.nvim",
    --     },
    --     enabled = function()
    --         return vim.version().minor >= 9
    --     end,
    --     build = "make",
    --     config = function()
    --         -- You dont need to set any of these options. These are the default ones. Only
    --         -- the loading is important
    --         require('telescope').setup {

    --         }
    --         -- To get fzf loaded and working with telescope, you need to call
    --         -- load_extension, somewhere after setup function:
    --         -- require('telescope').load_extension('fzf')
    --     end
    -- },
    {
        "ahmedkhalf/project.nvim",
        event = "VeryLazy",
        keys = {
            {
                "<leader>tp", "<cmd>Telescope projects<cr>",
                desc = "Find Projects",
            },
        },
        config = function()
            require("project_nvim").setup {
              -- your configuration comes here
              -- or leave it empty to use the default settings
              -- refer to the configuration section below
            }
            if H.has_plugin "telescope.nvim" then
                require('telescope').load_extension('projects')
            end
        end,
    }
}
