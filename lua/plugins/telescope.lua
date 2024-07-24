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
                "<leader>p", "<cmd>:Telescope find_files file_encoding=cp932<cr>",
                desc = "Telescope Files",
            },
            -- {
            --     "<leader>tt", ":Telescope lsp_workspace_symbols file_encoding=cp932 query=",
            --     desc = "Telescope query workspace Tags",
            -- },
            {
                "<leader>tc", "<cmd>:Telescope grep_string file_encoding=sjis<cr>",
                desc = "Telescope Current word",
            },
            {
                "<leader>tc", "",
                callback = function()
                    local tb = require('telescope.builtin')
                    
                    local cword = vim.fn.escape(H.get_visual_selection(), "[]()*+.$^")
                    tb.live_grep({
                        default_text = cword,
                        file_encoding = "sjis",
                    })
                    
                    -- tb.grep_string({
                    --     search = H.get_visual_selection(),
                    --     file_encoding = "sjis",
                    -- })
                end,
                desc = "Telescope Current word",
                mode = { "v" },
            },
            {
                "<leader>tk", "<cmd>:Telescope keymaps file_encoding=cp932<cr>",
                desc = "Telescope Keymaps",
            },
            -- {
            --     "<leader>tg", "<cmd>:Telescope live_grep file_encoding=cp932<cr>",
            --     desc = "Telescope Grep (Live)",
            -- },
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
            -- {
            --     "<leader>ti", "<cmd>:Telescope lsp_incoming_calls file_encoding=cp932<cr>",
            --     desc = "Telescope Incoming calls (LSP)",
            -- },
            -- {
            --     "<leader>tr", ":Telescope lsp_references file_encoding=cp932 query=",
            --     desc = "Telescope References (LSP)",
            -- },
            {
                "<leader>tl", ":Telescope live_grep file_encoding=sjis default_text=",
                desc = "Telescope Live grep",
            },
            {
                "<leader>tT", "<cmd>:Telescope treesitter file_encoding=cp932<cr>",
                desc = "Telescope Treesitter",
            },
            {
                "<leader>tR", "<cmd>:Telescope resume<cr>",
                desc = "Telescope Resume",
            },
            {
                "<leader>tq", "<cmd>:Telescope quickfixhistory<cr>",
                desc = "Telescope Quickfix history",
            },
        },
        init = function(_, opts)
            local actions = require "telescope.actions"
            local layout = require "telescope.actions.layout"
            opts = {
                extensions = {
                    -- fzf = {
                    --     fuzzy = true,                    -- false will only do exact matching
                    --     override_generic_sorter = true,  -- override the generic sorter
                    --     override_file_sorter = true,     -- override the file sorter
                    --     case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                    --                                     -- the default case_mode is "smart_case"
                    -- },
                    sessions_picker = {
                        sessions_dir = vim.fn.stdpath("data") .. "/sessions/",  -- same as '/home/user/.local/share/nvim/sessions'
                    }
                },
                preview = {
                    treesitter = false,
                },
                defaults = {
                    sorting_strategy = "ascending",
                    layout_strategy = "center",
                    layout_config = {
                        center = {
                            prompt_position = "top",
                            -- height = 0.99,
                            width = 0.8,
                            anchor = "N",
                            -- mirror = true,
                        },
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
                            ["<C-d>"] = actions.results_scrolling_down,
                            ["<C-u>"] = actions.results_scrolling_up,
                            ["<space>"] = actions.toggle_selection,
                            ["<tab>"] = false,  -- disable: select and go next
                            ["<S-tab>"] = false,  -- disable: select and go prev
                        },
                        i = {
                            -- ["<Down>"] = actions.cycle_history_next,
                            -- ["<Up>"] = actions.cycle_history_prev,
                            ["<C-space>"] = actions.to_fuzzy_refine,
                            ["<C-v>"] = function(_bufnr)
                                -- paste from system clipboard
                                local text = vim.fn.getreg("*")
                                vim.fn.setreg("v", string.gsub(text, "\n", ""))
                                vim.api.nvim_feedkeys(H.key"<C-r>", "n", false)
                                vim.api.nvim_feedkeys("v", "n", false)
                            end,
                            ["<C-n>"] = false,
                            ["<C-p>"] = layout.toggle_preview,
                            ["<C-d>"] = false,
                            ["<C-u>"] = false,  -- use default <C-u> behavior to clear prompt
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<Tab>"] = function(_bufnr)
                                -- use leaderF style keybinding: Tab to normal mode
                                vim.api.nvim_feedkeys(H.key"<Esc>", "n", false)
                            end,
                            ["<Esc>"] = function(_bufnr)
                                -- use leaderF style keybinding: single <Esc> click to exit
                                actions.close(_bufnr)
                                -- return to normal mode, ugly but it works
                                vim.api.nvim_feedkeys(H.key"<Esc>", "n", false)
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
        "rmagatti/auto-session",
        opts = {
            auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/", -- directory where session files are saved
            auto_session_suppress_dirs = {
                "C:\\App\\bin",
            },
        },        
    },
    {
        "JoseConseco/telescope_sessions_picker.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        keys = {
            {
                "<leader>tS", "<cmd>:Telescope sessions_picker<cr>",
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
                "<leader>td", "<cmd>:Telescope gtags_definitions file_encoding=cp932 initial_mode=normal<cr>",
                desc = "Telescope Definitions (Gtags)",
            },
            {
                "<leader>tr", "<cmd>:Telescope gtags_references file_encoding=cp932 initial_mode=normal<cr>",
                desc = "Telescope References (Gtags)",
            },
            {
                "<leader>ts", "<cmd>:Telescope gtags_symbol_usages file_encoding=cp932 initial_mode=normal<cr>",
                desc = "Telescope Symbols (Gtags)",
            },
            {
                "<leader>tt", "<cmd>:Telescope gtags_buffer_symbols file_encoding=cp932<cr>",
                desc = "Telescope buffer Tags (Gtags)",
            },
        },
        config = function()
            if H.has_plugin "telescope.nvim" then
                require('telescope').load_extension('gtags')
            end
        end,
    },
}
