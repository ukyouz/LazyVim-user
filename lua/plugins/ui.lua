local H = require "utils.helper"
local O = require "config.options"

return {
    {
        "ukyouz/onedark.vim",
        config = function()
            -- vim.g.onedark_style = "darker"
            vim.g.enable_semantic_highlight = true
            vim.cmd.colorscheme("onedark")

            -- vim.cmd([[hi Visual cterm=reverse gui=reverse]])
            -- local function clampColor(component)
            --     return math.min(math.max(component, 0), 255)
            -- end

            -- function tuneColor(color, shift)
            --     local r = math.floor(color / 0x10000) + shift
            --     local g = (math.floor(color / 0x100) % 0x100) + shift
            --     local b = (color % 0x100) + shift
            --     return clampColor(r) * 0x10000 + clampColor(g) * 0x100 + clampColor(b)
            -- end
            -- -- darken the Search background to make cursor visible even at highlighted yellow text
            -- local hi = vim.api.nvim_get_hl(0, {name = "Search"})
            -- hi.bg = tuneColor(hi.bg, -50)
            -- vim.api.nvim_set_hl(0, "Search", hi)
        end,
    },
    {
        "pangloss/vim-javascript",
    },
    {
        "justinmk/vim-syntax-extra", -- better c/c++
    },
    {
        "ukyouz/syntax-highlighted-cursor.nvim",
        enabled = function()
            return vim.version().minor >= 9 and vim.fn.exists('g:gui_vimr') == 0
        end,
        opts = {
            debounce_ms = 70,
            force_refresh_hack = true,
            -- when_cursor_moved = false,
            when_cursor_hold = false,
        },
    },
    {
        "kevinhwang91/nvim-hlslens",
        enabled = false,
        config = function(opts)
            require("hlslens").setup({
                build_position_cb = function(plist, _, _, _)
                    require("scrollbar.handlers.search").handler.show(plist.start_pos)
                end,
                override_lens = function(render, posList, nearest, idx, relIdx)
                    -- local sfw = vim.v.searchforward == 1
                    -- local indicator, text, chunks
                    -- local absRelIdx = math.abs(relIdx)
                    -- if absRelIdx > 1 then
                    --     indicator = ('%d%s'):format(absRelIdx, sfw ~= (relIdx > 1) and 'N' or 'n')
                    -- elseif absRelIdx == 1 then
                    --     indicator = sfw ~= (relIdx == 1) and '▲' or '▼'
                    -- else
                    --     indicator = ''
                    -- end

                    -- local lnum, col = unpack(posList[idx])
                    -- if nearest then
                    --     local cnt = #posList
                    --     if indicator ~= '' then
                    --         text = ('%s'):format(indicator)
                    --     else
                    --         text = ''
                    --     end
                    --     chunks = {{' '}, {text, 'HlSearchLensNear'}}
                    -- else
                    --     text = ('%s'):format(indicator)
                    --     chunks = {{' '}, {text, 'HlSearchLens'}}
                    -- end
                    -- render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
                end,
            })
            vim.cmd([[
                augroup scrollbar_search_hide
                    autocmd!
                    autocmd CmdlineLeave : lua require('scrollbar.handlers.search').handler.hide()
                augroup END
            ]])
        end,
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
        opts = {
            font = O.fontfamily,
            default = O.fontsize,
        },
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
        "ukyouz/context.vim",
        branch = "imp_perf",
        init = function()
            vim.g.context_add_autocmds = 0
            vim.g.context_ellipsis_char = '~'
        end,
        config = function()
            -- disable CursorMoved autocmd to reduce lag
            vim.cmd([[
                autocmd VimEnter     * ContextActivate
                autocmd BufAdd       * if &buftype != 'prompt' && &buftype != 'terminal' | call context#update('BufAdd') | endif
                autocmd BufEnter     * if &buftype != 'prompt' && &buftype != 'terminal' | call context#update('BufEnter') | endif
                "autocmd CursorMoved  * call context#update('CursorMoved')
                autocmd VimResized   * call context#update('VimResized')
                autocmd CursorHold   * call context#update('CursorHold')
                autocmd User GitGutter call context#update('GitGutter')
                autocmd OptionSet number,relativenumber,numberwidth,signcolumn,tabstop,list
                            \          call context#update('OptionSet')

                if exists('##WinScrolled')
                    autocmd WinScrolled * if &buftype != 'prompt' && &buftype != 'terminal' | call context#update('WinScrolled') | endif
                endif
            ]])
        end,
    },
    {
        "RRethy/vim-illuminate",
        event = "VeryLazy",
        config = function()
vim.cmd([[
                hi IlluminatedWordText gui=bold guibg=black cterm=bold
                hi IlluminatedWordRead gui=bold guibg=black cterm=bold
                hi IlluminatedWordWrite gui=bold guibg=black cterm=bold
            ]])

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
        "machakann/vim-highlightedyank",
        init = function()
            vim.g.highlightedyank_highlight_duration = 250
        end,
    },
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
                "<s-cr>",
                "<cmd>Hi{<cr>",
            },
            {
                "<PageDown>",
                "<cmd>Hi]<cr>",
            },
            {
                "<PageUp>",
                "<cmd>Hi[<cr>",
            },
        },
        init = function()
            vim.cmd("let HiSet = 'm<cr>'")
            vim.cmd("let HiErase = 'm<bs>'")
            vim.cmd("let HiClear = 'm<del>'")
            vim.cmd("let HiSyncMode = 1")
            H.augroup("AddHighlighterKeymap", {
                {
                    events = {"BufEnter"},
                    opts = {
                        callback = function()
                            if vim.bo.buftype == "nofile" then
                                return
                            end
                            if vim.bo.buftype == "quickfix" then
                                return
                            end
                            vim.cmd("nmap <buffer> <CR> <cmd>Hi}<cr>")
                        end,
                    },
                }
            })
        end,
    },
    {
        "kshenoy/vim-signature",
        event = "VeryLazy",
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
                lualine_a = {
                    {
                        'mode',
                        fmt = function(str) return str:sub(1,1) end
                    },
                },
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
                -- lualine_y = {},
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
        enabled = false,
        opts = {
            show_in_active_only = false,
            marks = {
                Search = { highlight = "IncSearch" },
                Warn = { highlight = "Number" },
            },
        },
        init = function(_, opts)
            if H.has_plugin "gitsigns.nvim" then
                require("scrollbar.handlers.gitsigns").setup(opts)
            end
            if H.has_plugin "nvim-hlslens" then
                require("scrollbar.handlers.search").setup(opts)
            end
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        enabled = vim.fn.executable("git"),
        -- ft = "gitcommit",
        keys = {
            -- GitSigns
            {"]g", function() require("gitsigns").next_hunk() end, desc = "Next Git hunk" },
            {"[g", function() require("gitsigns").prev_hunk() end, desc = "Previous Git hunk" },
            {"<leader>gl", function() require("gitsigns").blame_line() end, desc = "View Git blame" },
            {"<leader>gL", function() require("gitsigns").blame_line { full = true } end, desc = "View full Git blame" },
            {"<leader>gp", function() require("gitsigns").preview_hunk() end, desc = "Preview Git hunk" },
            {"<leader>gh", function() require("gitsigns").reset_hunk() end, desc = "Reset Git hunk" },
            {"<leader>gr", function() require("gitsigns").reset_buffer() end, desc = "Reset Git buffer" },
            {"<leader>gs", function() require("gitsigns").stage_hunk() end, desc = "Stage Git hunk" },
            {"<leader>gS", function() require("gitsigns").stage_buffer() end, desc = "Stage Git buffer" },
            {"<leader>gu", function() require("gitsigns").undo_stage_hunk() end, desc = "Unstage Git hunk" },
            -- {"<leader>gd", "", callback = function() require("gitsigns").diffthis() end, desc = "View Git diff" },
        },
        opts = {
            signcolumn = true,
            signs = {
                add = {
                    text = "┆",
                },
                change = {
                    text = "┆",
                },
                delete = {
                    text = "▁",
                },
                topdelete = {
                    text = "▔",
                },
                changedelete = {
                    text = "┆",
                },
                untracked = {
                    text = "┆",
                },
            },
            max_file_length = 100000,
        },
    },
    {
        "preservim/nerdtree",
        -- cond = false,
        enabled = false,
        keys = {
            {"<leader>e", "<cmd>:NERDTreeToggle<cr>"},
        },
        config = function()
            vim.cmd([[
                function! NTreeMapCloseDir()
                    let n = g:NERDTreeFileNode.GetSelected()
                    if n != {} && !n.isRoot()
                        if !n.path.isDirectory || !n.isOpen
                            let p = n.parent
                            call p.close()
                            call b:NERDTree.render()
                            call p.putCursorHere(0,0)
                        else " if the node is a opened dir
                            call n.close()
                            call b:NERDTree.render()
                        endif
                    endif
                endfunction
                function! NTreeMapOpenDir()
                    let n = g:NERDTreeFileNode.GetSelected()
                    if n != {}
                        if n.path.isDirectory
                            call n.open()
                            call b:NERDTree.render()
                        endif
                    endif
                endfunction
            ]])
            vim.fn.NERDTreeAddKeyMap({ key= 'h', callback= 'NTreeMapCloseDir' })
            vim.fn.NERDTreeAddKeyMap({ key= 'l', callback= 'NTreeMapOpenDir' })
        end,
    }
}