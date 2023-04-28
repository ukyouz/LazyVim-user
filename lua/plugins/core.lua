return {
    {
        "ukyouz/onedark.vim",
        config = function()
            vim.g.onedark_style = "darker"
            vim.cmd.colorscheme("onedark")
        end,
    },
    {
        "vim-airline/vim-airline",
        dependencies = {
            "vim-airline/vim-airline-themes",
        },
        init = function()
            vim.g.airline_theme = "bubblegum"
            vim.cmd("let g:airline#extensions#branch#enabled = 0")
            vim.cmd("let g:airline#extensions#tabline#enabled = 0")
            vim.cmd("let g:airline#extensions#whitespace#enabled = 0")
            vim.cmd("let g:airline#extensions#vista#enabled = 0")
            vim.cmd("let g:airline#extensions#tagbar#flags = 'f'")
            vim.cmd("let g:airline_highlighting_cache = 1")
            vim.cmd("let g:airline#extensions#hunks#enabled = 0")
            vim.cmd("let g:airline_skip_empty_sections = 1")
        end,
        config = function()
            -- if vim.g.airline_symbols == nil then
            --     vim.g.airline_symbols = {}
            -- end
            vim.g.airline_section_z = "" -- current position in the file
            vim.g.airline_symbols.maxlinenr = ""
            vim.g.airline_symbols.linenr = " "
            vim.g.airline_symbols.colnr = ":"
        end,
    },
    {
        "mrjones2014/smart-splits.nvim",
        event = "VeryLazy",
    },
    {
        "folke/which-key.nvim",
        opts = {
            icons = {
                group = vim.g.icons_enabled and "" or "+",
                separator = "",
            },
            --   disable = { filetypes = { "TelescopePrompt" } },
        },
        config = function(_, opts)
            require("which-key").setup(opts)
        end,
    },
    {
        "Shatur/neovim-session-manager",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        event = "VimLeave",
        cmd = "SessionManager",
    },
    {
        "wellle/context.vim",
        event = "BufEnter",
        config = function()
            local group = vim.api.nvim_create_augroup("context_au", {
                clear = true,
            })
            vim.api.nvim_create_autocmd({
                "BufEnter",
            }, {
                pattern = {
                    "term://*",
                    "term://*toggleterm#*",
                },
                desc = "Enable context.vim for current buffer",
                group = group,
                command = "ContextDisableWindow",
            })
        end,
    },
    {
        "machakann/vim-highlightedyank",
        event = "BufReadPost",
        init = function()
            vim.g.highlightedyank_highlight_duration = 200
        end,
    },
    {
        "ukyouz/Vim-C-Defines",
        event = "BufReadPost",
        ft = {
            "c",
            "cpp",
        },
        config = function()
            vim.api.nvim_set_keymap("n", "<leader>rd", "", {
                desc = "Reveal definition",
                noremap = false,
                callback = function()
                    local cword = vim.fn.expand("<cword>")
                    vim.api.nvim_exec(string.format("CdfCalculateToken %s", cword), false)
                end,
            })
            vim.api.nvim_set_keymap("x", "<leader>rd", "", {
                desc = "Reveal definition",
                noremap = false,
                callback = function()
                    local cword = vim.fn.expand("<cword>")
                    vim.api.nvim_exec(string.format("CdfCalculateToken %s", cword), false)
                end,
            })
        end,
    },
    {
        "skywind3000/vim-preview",
        event = "BufReadPost",
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
    }, ---- better text object action ----
    {
        "azabiong/vim-highlighter",
        keys = {
            {
                "m<cr>",
                desc = "Mark word",
            },
            {
                "m<bs>",
                desc = "Mark delete",
            },
            {
                "m<del>",
                desc = "Mark clear",
            },
            {
                "<cr>",
                "<cmd>Hi}<cr>",
            },
        },
        init = function()
            vim.cmd("let HiSet = 'm<cr>'")
            vim.cmd("let HiErase = 'm<bs>'")
            vim.cmd("let HiClear = 'm<del>'")
        end,
    },
    {
        "tpope/vim-surround",
        event = "BufReadPost",
    }, -- add surround movement
    {
        "tpope/vim-repeat",
        event = "BufReadPost",
    }, -- better . repeat action
    {
        "tpope/vim-unimpaired",
        event = "BufReadPost",
    }, -- add common `[`, `]` movement
    {
        "wellle/targets.vim",
        event = "BufReadPost",
    }, -- add more textobject
    {
        "michaeljsmith/vim-indent-object",
        event = "BufReadPost",
    }, -- add indent as a textobject
    {
        "mg979/vim-visual-multi",
        event = "BufReadPost",
        config = function()
            vim.g.VM_theme = "codedark"
        end,
    },
}
