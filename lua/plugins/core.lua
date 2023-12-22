return {
    {
        "ukyouz/onedark.vim",
        config = function()
            vim.g.onedark_style = "darker"
            vim.cmd.colorscheme("onedark")
        end,
    },
    {
        "ukyouz/syntax-highlighted-cursor.nvim",
        config = function()
            require("syntax-highlighted-cursor").setup()
        end,
    },
    {
        "vim-airline/vim-airline",
        enabled = false,
        dependencies = {
            "vim-airline/vim-airline-themes",
        },
        init = function()
            vim.g.airline_theme = "bubblegum"
            vim.cmd("let g:airline#extensions#branch#enabled = 0")
            vim.cmd("let g:airline#extensions#tabline#enabled = 0")
            vim.cmd("let g:airline#extensions#whitespace#enabled = 0")
            vim.cmd("let g:airline#extensions#vista#enabled = 0")
            -- vim.cmd("let g:airline#extensions#tagbar#flags = 'f'")
            -- vim.cmd("let g:airline_highlighting_cache = 1")
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
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            options = {
                component_separators = {
                    left = "",
                    right = "",
                },
                section_separators = { left = '', right = ''},
                -- refresh = {
                --     statusline = 86400,
                -- },
            },
            sections = {
                lualine_b = {},
                lualine_c = {
                    {
                        "filename",
                        path = 1,
                    },
                },
                lualine_x = {
                    {
                        "searchcount",
                        maxcount = 9999,
                    },
                    {
                        "encoding",
                    },
                    {
                        "fileformat",
                    },
                    {
                        "filetype",
                    },
                    {
                        "diagnostics",
                    },
                },
            },
            inactive_sections = {
                lualine_b = {},
                lualine_c = {
                    {
                        "filename",
                        path = 1,
                    },
                },
                lualine_x = {
                    {
                        "searchcount",
                        maxcount = 9999,
                    },
                    {
                        "encoding",
                    },
                    {
                        "fileformat",
                    },
                    {
                        "filetype",
                    },
                },
            },
        },
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
            triggers_nowait = {
                -- marks
                "`",
                "'",
                "g`",
                "g'",
                -- registers
                -- '"',
                -- "<c-r>",
                -- spelling
                "z=",
            },
            --   disable = { filetypes = { "TelescopePrompt" } },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)

            wk.register({["<leader>f"] = { name = "+Leaderf" }})
            wk.register({["<leader>g"] = { name = "+Git" }})
            wk.register({["<leader>l"] = { name = "+Lsp" }})
            wk.register({["<leader>s"] = { name = "+Session" }})
            wk.register({["<leader>t"] = { name = "+Telescope" }})
        end,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            keywords = {
                JTODO = { icon = " ", color = "info" },
            },
        }
    },
    {
        "folke/flash.nvim",
        enabled = false,
        event = "VeryLazy",
        opts = {
            modes = {
                char = {
                    keys = { "f", "F", "t", "T", "," },
                },
            },
        },
        -- stylua: ignore
        keys = {
          { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
          { "t", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
          { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
          { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        --   { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
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
        "RRethy/vim-illuminate",
        event = "VeryLazy",
        config = function()
            require('illuminate').configure({
                providers = {
                    -- 'treesitter',
                    'lsp',
                    'regex',
                },
                delay = 300,
            })
        end
    },
    {
        "NvChad/nvim-colorizer.lua",
        cmd = {
            "ColorizerToggle",
            "ColorizerAttachToBuffer",
            "ColorizerDetachFromBuffer",
            "ColorizerReloadAllBuffers",
        },
        opts = {
            user_default_options = {
                names = false,
            },
        },
    },
    {
        "github/copilot.vim",
    },
    {
        "machakann/vim-highlightedyank",
        init = function()
            vim.g.highlightedyank_highlight_duration = 250
        end,
    },
    {
        "ukyouz/Vim-C-Defines",
        ft = {
            "c",
            "cpp",
        },
        config = function()
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
            {
                "<s-cr>",
                "<cmd>Hi{<cr>",
            },
        },
        init = function()
            vim.cmd("let HiSet = 'm<cr>'")
            vim.cmd("let HiErase = 'm<bs>'")
            vim.cmd("let HiClear = 'm<del>'")
            vim.cmd("let HiSyncMode = 1")
        end,
    },
    {
        "tpope/vim-surround",
    }, -- add surround movement
    {
        "numToStr/Comment.nvim",
        keys = {
            {
                "gc",
                mode = {
                    "n",
                    "v",
                },
            },
            {
                "gb",
                mode = {
                    "n",
                    "v",
                },
            },
        },
        opts = {
            -- ignores empty lines
            ignore = '^$',
        },
    }, -- better comment action
    {
        "tpope/vim-repeat",
    }, -- better . repeat action
    {
        "tpope/vim-unimpaired",
    }, -- add common `[`, `]` movement
    {
        "kshenoy/vim-signature",
        event = "VeryLazy",
    },
    {
        "michaeljsmith/vim-indent-object",
    }, -- add indent as a textobject
    {
        "mg979/vim-visual-multi",
        config = function()
            vim.g.VM_theme = "codedark"
        end,
    },
    {
        "bkad/CamelCaseMotion",
        event = "VeryLazy",
        init = function()
            vim.g.camelcasemotion_key = "\\"
        end,
    },
    {
        "stevearc/aerial.nvim",
        keys = {
            {
                "<leader>ls",
                "",
                callback = function()
                    require("aerial").toggle()
                end,
                desc = "List Symbols outline",
                -- maps.n["<leader>lS"] = { , desc = "Symbols outline" }
            },
        },
        opts = {
            attach_mode = "global",
            backends = {
                "lsp",
                "treesitter",
                "markdown",
                "man",
            },
            layout = {
                min_width = 28,
            },
            disable_max_lines = 50000,
            show_guides = true,
            -- filter_kind = false,
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
}
