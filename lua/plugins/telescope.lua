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
                "<leader>tf", "<cmd>:Telescope find_files file_encoding=cp932<cr>",
                desc = "Telescope Files",
            },
            {
                "<leader>tt", ":Telescope lsp_workspace_symbols file_encoding=cp932 query=",
                desc = "Telescope query workspace Tags",
            },
            {
                "<leader>tc", "<cmd>:Telescope grep_string file_encoding=sjis<cr>",
                desc = "Telescope Current word",
            },
            {
                "<leader>tk", "<cmd>:Telescope keymaps file_encoding=cp932<cr>",
                desc = "Telescope Keymaps",
            },
            {
                "<leader>tg", "<cmd>:Telescope live_grep file_encoding=cp932<cr>",
                desc = "Telescope Grep (Live)",
            },
            {
                "<leader>tb", "<cmd>:Telescope buffers file_encoding=cp932<cr>",
                desc = "Telescope Buffers",
            },
            {
                "<leader>th", "<cmd>:Telescope help_tags file_encoding=cp932<cr>",
                desc = "Telescope Helps",
            },
            {
                "<leader>tk", "<cmd>:Telescope keymaps file_encoding=cp932<cr>",
                desc = "Telescope Keymaps",
            },
            {
                "<leader>ti", "<cmd>:Telescope lsp_incoming_calls file_encoding=cp932<cr>",
                desc = "Telescope Incoming calls (LSP)",
            },
            {
                "<leader>tr", ":Telescope lsp_references file_encoding=cp932 query=",
                desc = "Telescope References (LSP)",
            },
        },
        init = function(_, opts)
            local actions = require "telescope.actions"
            local layout = require "telescope.actions.layout"
            opts = {
                extensions = {
                    fzf = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                                        -- the default case_mode is "smart_case"
                    },
                    sessions_picker = {
                        sessions_dir = vim.fn.stdpath("data") .. "/sessions/",  -- same as '/home/user/.local/share/nvim/sessions'
                    }
                },
                defaults = {
                    sorting_strategy = "ascending",
                    layout_strategy = "vertical",
                    layout_config = {
                        vertical = {
                            prompt_position = "top",
                            height = 0.99,
                            -- width = 0.8,
                            anchor = "N",
                            mirror = true,
                            preview_cutoff = 0, -- always show preview event at small visible region
                        },
                    },
                    path_display = {
                        "smart",
                        "shorten",
                        "truncate",
                    },
                    mappings = {
                        n = {
                            ["p"] = layout.toggle_preview,
                            ["<C-p>"] = layout.toggle_preview,
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-d>"] = false,
                            ["<C-u>"] = false,  -- use default <C-u> behavior to clear prompt
                        },
                        i = {
                            -- ["<Down>"] = actions.cycle_history_next,
                            -- ["<Up>"] = actions.cycle_history_prev,
                            ["<C-v>"] = function(_bufnr)
                                -- paste from system clipboard
                                vim.cmd [[noautocmd sil <C-r>*]]
                            end,
                            ["<C-n>"] = false,
                            ["<C-p>"] = layout.toggle_preview,
                            ["<C-d>"] = false,
                            ["<C-u>"] = false,  -- use default <C-u> behavior to clear prompt
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
                opts.defaults.mappings.n["<A-d>"] = actions.preview_scrolling_down
                opts.defaults.mappings.n["<A-u>"] = actions.preview_scrolling_up
                opts.defaults.mappings.i["<A-d>"] = actions.preview_scrolling_down
                opts.defaults.mappings.i["<A-u>"] = actions.preview_scrolling_up
            else
                opts.defaults.mappings.n["<D-d>"] = actions.preview_scrolling_down
                opts.defaults.mappings.n["<D-u>"] = actions.preview_scrolling_up
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
        "natecraddock/sessions.nvim",
        config = function()
            require("sessions").setup({
                -- events = { "WinEnter" },
                session_filepath = vim.fn.stdpath("data") .. "/sessions",
                absolute = true,
            })
            H.augroup("autosavesession", {
                {
                    events = {"QuitPre"},
                    opts = {
                        pattern = {"*"},
                        desc = "Save session when quit",
                        command = "silent! SessionsSave"
                    },
                },
            })
        end
    },
    {
        "JoseConseco/telescope_sessions_picker.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        keys = {
            {
                "<leader>ts", "<cmd>:Telescope sessions_picker<cr>",
                desc = "Find Session",
            },
        },
        config = function()
            if H.has_plugin "telescope.nvim" then
                require('telescope').load_extension('sessions_picker')
            end
        end,
    },
    {
        "ukyouz/telescope-gtags",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        keys = {
            {
                "<leader>tg", "<cmd>:Telescope gtags file_encoding=cp932<cr>",
                desc = "Telescope Gtag symbols",
            },
            {
                "<leader>tr", "<cmd>:Telescope gtags_references file_encoding=cp932 initial_mode=normal<cr>",
                desc = "Telescope References (LSP)",
            },
        },
        config = function()
            if H.has_plugin "telescope.nvim" then
                require('telescope').load_extension('gtags')
            end
        end,
    },
}
