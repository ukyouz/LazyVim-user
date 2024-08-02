return {
    {
        "ukyouz/Vim-C-Defines",
        ft = {
            "c",
            "cpp",
        },
        config = function()
            vim.g.Cdf_SupportSourceExtensions = {
                ".c",
                ".C",
                ".cpp",
                ".CPP",
            }
            vim.g.Cdf_SupportHeaderExtensions = {
                ".h",
                ".hh",
            }
            vim.g.Cdf_CacheDirectory = vim.fn.stdpath("data") .. "/cdf_cache"
            vim.api.nvim_set_keymap("n", "<leader>rd", ":<C-R>=printf('CdfCalculateToken %s', expand('<cword>'))<CR><CR>", {
                desc = "Reveal definition",
                noremap = false,
            })
            vim.api.nvim_set_keymap("x", "<leader>rd", ":<C-U><C-R>=printf('CdfCalculateToken %s', CdfGetVisualSelection())<CR><CR>", {
                desc = "Reveal definition",
                noremap = false,
                silent = false,
            })
        end,
    },
    {
        "skywind3000/vim-preview",
        ft = {
            "c",
            "cpp",
            "python",
        },
        config = function()
            vim.api.nvim_exec("let g:preview#preview_position = 'bottom'", false)
            vim.api.nvim_exec("let g:preview#preview_size = '13'", false)
            vim.api.nvim_set_keymap("n", "<C-p>", "<cmd>:PreviewTag<cr>", {
                desc = "Preview current tag",
                noremap = false,
            })
            vim.api.nvim_set_keymap("n", "<C-z>", "<cmd>:PreviewClose<cr>", {
                desc = "Preview close",
                noremap = false,
            })
        end,
    },
    {
        "stevearc/aerial.nvim",
        keys = {
            {
                "<leader>ls",
                function()
                    require("aerial").toggle()
                end,
                desc = "List Symbols outline",
            },
        },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
        opts = {
            attach_mode = "window",
            backends = {
                "lsp",
                "treesitter",
                "markdown",
                "man",
            },
            layout = {
                min_width = 28,
            },
            -- disable_max_lines = 50000,
            show_guides = true,
            filter_kind = false,
            guides = {
                mid_item = "├ ",
                last_item = "└ ",
                nested_top = "│ ",
                whitespace = "  ",
            },
            keymaps = {
                ["[y"] = "actions.prev",
                ["]y"] = "actions.next",
                ["[Y"] = "actions.prev_up",
                ["]Y"] = "actions.next_up",
                ["{"] = false,
                ["}"] = false,
                ["[["] = false,
                ["]]"] = false,
            },
        },
    },
    {
        -- only work for Neovim version < 0.9.0
        "ukyouz/vim-gutentags",
        enabled = false,
        event = "VeryLazy",
        branch = "improve_update_perf",
        -- ft = {
        --     "c",
        --     "cpp",
        --     "php",
        --     "python",
        -- },
        init = function()
            local user_dir = vim.fn.expand('~/LeaderF/gtags')
            -- vim.o.cscopetag = true
            -- vim.o.cscopeprg = "gtags-cscope"
            vim.g.gutentags_modules = {
                "ctags",
                "gtags_cscope",
            }
            vim.g.gutentags_cache_dir = user_dir
            vim.g.gutentags_generate_on_missing = 1
            vim.g.gutentags_generate_on_write = 1
        end,
    },
    {
        "liuchengxu/vista.vim",
        enabled = false,
        keys = {
            {
                "<leader>ls",
                "<cmd>:Vista!!<cr>",
                desc = "List Symbols outline",
                noremap = false,
            },
        },
        config = function()
            vim.cmd("let g:vista#renderer#enable_icon = 1")
        end,
    },
}
