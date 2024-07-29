local H = require "utils.helper"

return {
    {
        "ukyouz/onedark.vim",
        config = function()
            vim.g.onedark_style = "darker"
            vim.cmd.colorscheme("onedark")

            vim.cmd([[hi Visual cterm=reverse gui=reverse]])
        end,
    },
    {
        "ukyouz/syntax-highlighted-cursor.nvim",
        enabled = function()
            return vim.version().minor >= 9
        end,
        config = function()
            require("syntax-highlighted-cursor").setup()

            local function clampColor(component)
                return math.min(math.max(component, 0), 255)
            end

            function tuneColor(color, shift)
                local r = math.floor(color / 0x10000) + shift
                local g = (math.floor(color / 0x100) % 0x100) + shift
                local b = (color % 0x100) + shift
                return clampColor(r) * 0x10000 + clampColor(g) * 0x100 + clampColor(b)
            end
            -- darken the Search background to make cursor visible even at highlighted yellow text
            local hi = vim.api.nvim_get_hl(0, {name = "Search"})
            hi.bg = tuneColor(hi.bg, -50)
            vim.api.nvim_set_hl(0, "Search", hi)
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
                lualine_y = {},
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
        "petertriho/nvim-scrollbar",
        opts = {
            show_in_active_only = false,
            marks = {
                Search = { highlight = "IncSearch" },
            },
        },
        init = function(_, opts)
            if H.has_plugin "gitsigns.nvim" then
                require("scrollbar.handlers.gitsigns").setup(opts)
            end
            if H.has_plugin "nvim-hlslens" then
                require("scrollbar.handlers.search").setup({
                    override_lens = function(render, posList, nearest, idx, relIdx)
                        local sfw = vim.v.searchforward == 1
                        local indicator, text, chunks
                        local absRelIdx = math.abs(relIdx)
                        if absRelIdx > 1 then
                            indicator = ('%d%s'):format(absRelIdx, sfw ~= (relIdx > 1) and 'N' or 'n')
                        elseif absRelIdx == 1 then
                            indicator = sfw ~= (relIdx == 1) and '▲' or '▼'
                        else
                            indicator = ''
                        end

                        local lnum, col = unpack(posList[idx])
                        if nearest then
                            local cnt = #posList
                            if indicator ~= '' then
                                text = ('%s'):format(indicator)
                            else
                                text = ''
                            end
                            chunks = {{' '}, {text, 'HlSearchLensNear'}}
                        else
                            text = ('%s'):format(indicator)
                            chunks = {{' '}, {text, 'HlSearchLens'}}
                        end
                        render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
                    end,
                })
            end
        end,
    },
    {
        "kevinhwang91/nvim-hlslens",
    },
    {
        "mrjones2014/smart-splits.nvim",
        event = "VeryLazy",
    },
    {
        "ukyouz/fontsize.nvim",
        branch = "dev",
        keys = {
            { "<c-f12>", "<cmd>:FontIncrease<cr>" },
            { "<c-f11>", "<cmd>:FontDecrease<cr>" },
            { "<c-f10>", "<cmd>:FontReset<cr>" },
        },
        init = function()
            local opts = {
                font = "FiraCode Nerd Font",
                default = 10,
            }
            require("fontsize").init(opts)
        end,
    },
    {
        "folke/which-key.nvim",
        opts = {
            icons = {
                group = vim.g.icons_enabled and "" or "+",
                separator = "",
            },
            -- triggers_nowait = {
            --     -- marks
            --     "`",
            --     "'",
            --     "g`",
            --     "g'",
            --     -- registers
            --     -- '"',
            --     -- "<c-r>",
            --     -- spelling
            --     "z=",
            -- },
            --   disable = { filetypes = { "TelescopePrompt" } },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            wk.add({
                { "<leader>f", group = "Leaderf" },
                { "<leader>g", group = "Git" },
                { "<leader>l", group = "Lsp" },
                { "<leader>s", group = "Session" },
                { "<leader>t", group = "Telescope" },
                { "m", group = "Mark" },
            })
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
        init = function()
            vim.g.context_add_autocmds = 0
        end,
        config = function()
            -- disable CursorMoved autocmd to reduce lag
            vim.cmd([[
                autocmd VimEnter     * ContextActivate
                autocmd BufAdd       * call context#update('BufAdd')
                autocmd BufEnter     * if &buftype != 'prompt' && &buftype != 'terminal' | call context#update('BufEnter') | endif
                "autocmd CursorMoved  * call context#update('CursorMoved')
                autocmd VimResized   * call context#update('VimResized')
                autocmd CursorHold   * call context#update('CursorHold')
                autocmd User GitGutter call context#update('GitGutter')
                autocmd OptionSet number,relativenumber,numberwidth,signcolumn,tabstop,list
                            \          call context#update('OptionSet')

                if exists('##WinScrolled')
                    autocmd WinScrolled * call context#update('WinScrolled')
                endif
            ]])
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
    {
        "ThePrimeagen/refactoring.nvim",
        keys = {
            {
                "<leader>Rf",
                ":Refactor extract ",
                desc = "Refactor: extract to Function...",
                mode = { "x" },
            },
            {
                "<leader>Rv",
                ":Refactor extract_var ",
                desc = "Refactor: extract to Var...",
                mode = { "x" },
            },
            {
                "<leader>Ri",
                ":Refactor inline_var",
                desc = "Refactor: Inline assigned value",
                mode = { "n", "x" },
            },
            {
                "<leader>Rb",
                ":Refactor extract_block ",
                desc = "Refactor: extract Block as function...",
                mode = { "n", "x" },
            },
            {
                "<leader>Rr",
                function()
                    require("refactoring").select_refactor()
                end,
                desc = "Refactor menu",
                mode = { "n", "x" },
            },
        }
        -- opts = {
        --     prompt_func_return_type = {
        --         go = false,
        --         java = false,

        --         cpp = false,
        --         c = false,
        --         h = false,
        --         hpp = false,
        --         cxx = false,
        --     },
        --     prompt_func_param_type = {
        --         go = false,
        --         java = false,

        --         cpp = false,
        --         c = false,
        --         h = false,
        --         hpp = false,
        --         cxx = false,
        --     },
        --     printf_statements = {},
        --     print_var_statements = {},
        --     show_success_message = false, -- shows a message with information about the refactor on success
        --                                   -- i.e. [Refactor] Inlined 3 variable occurrences
        -- },
    },
    {
        "mangelozzi/rgflow.nvim",
        -- enabled = false,
        dependencies = {
            "junegunn/fzf",
        },
        keys = {
            { "<leader>rg", function() require('rgflow').open_cword_path() end, desc = "Rgflow Current Word", mode = { "n" }, },
            { "<leader>rg", function() require('rgflow').open_visual() end, desc = "Rgflow Selection", mode = { "x" }, },
            { "<leader>rr", function() require('rgflow').open_again() end, desc = "Rgflow Resume", mode = { "n" }, },
            { "<leader>rh", function() require('rgflow').show_rg_help() end, desc = "Rgflow Help", mode = { "n" }, },
        },
        opts = {
            -- Set the default rip grep flags and options for when running a search via
            -- RgFlow. Once changed via the UI, the previous search flags are used for 
            -- each subsequent search (until Neovim restarts).
            cmd_flags = "--smart-case --fixed-strings",

            -- Mappings to trigger RgFlow functions
            default_trigger_mappings = false,
            -- These mappings are only active when the RgFlow UI (panel) is open
            default_ui_mappings = true,
            -- QuickFix window only mapping
            default_quickfix_mappings = false,

            quickfix = {
                open_qf_cmd_or_func = "botright copen", -- Open the quickfix window across the full bottom edge
            },

            new_list_always_appended = true,  -- preserve quick fix history
        },
    },
    {
        'kevinhwang91/nvim-bqf',
        ft = 'qf',
        keys = {
            {"<", "<cmd>:colder<cr>", ft = {"qf"} },
            {">", "<cmd>:cnewer<cr>", ft = {"qf"} },
        },
        init = function()            
            opts = {
                preview = {
                    auto_preview = false,
                },
                func_map = {
                    stogglebuf = "%",
                },
            }
            if H.is_windows() then
                opts.func_map.pscrollup = "<A-u>"
                opts.func_map.pscrolldown = "<A-d>"
            else
                opts.func_map.pscrollup = "<D-u>"
                opts.func_map.pscrolldown = "<D-d>"
            end
            require("bqf").setup(opts)
        end,
    },
}
