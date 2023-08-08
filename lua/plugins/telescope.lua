local H = require "utils.helper"

return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        event = "VeryLazy",
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
            {
                "<leader>tk", "<cmd>:Telescope keymaps<cr>",
                desc = "Find Helps",
            },
        },
        init = function(_, opts)
            local actions = require "telescope.actions"
            opts = {
                extensions = {
                    fzf = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                                        -- the default case_mode is "smart_case"
                    }
                },
                defaults = {
                    sorting_strategy = "ascending",
                    layout_strategy = "vertical",
                    layout_config = {
                        vertical = {
                            prompt_position = "top",
                            -- height = 0.4,
                            -- width = 0.8,
                            anchor = "N",
                            mirror = true,
                            preview_cutoff = 0, -- always show preview event at small visible region
                        },
                    },
                    mappings = {
                        i = {
                            ["<Down>"] = actions.cycle_history_next,
                            ["<Up>"] = actions.cycle_history_prev,
                            ["<C-d>"] = false,
                            ["<C-u>"] = false,
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<Tab>"] = function(_bufnr)
                                -- use leaderF style keybinding: Tab to normal mode
                                local key = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
                                vim.api.nvim_feedkeys(key, "n", false)
                            end,
                            ["<Esc>"] = function(_bufnr)
                                -- use leaderF style keybinding: single <Esc> click to exit
                                actions.close(_bufnr)
                                -- return to normal mode, ugly but it works
                                local key = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
                                vim.api.nvim_feedkeys(key, "n", false)
                            end,
                        },
                    }
                },
            }
            if H.is_windows() then
                opts.defaults.mappings.i["<A-d>"] = actions.preview_scrolling_down
                opts.defaults.mappings.i["<A-u>"] = actions.preview_scrolling_up
            else
                opts.defaults.mappings.i["<D-d>"] = actions.preview_scrolling_down
                opts.defaults.mappings.i["<D-u>"] = actions.preview_scrolling_up
            end
            require('telescope').setup(opts)
        end
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
                exclude_dirs = {
                    "c:/Users/johnny_cheng",
                    "d:",
                },
            }
            if H.has_plugin "telescope.nvim" then
                require('telescope').load_extension('projects')
            end
        end,
    }
}
