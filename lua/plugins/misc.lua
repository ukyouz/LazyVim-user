local H = require "utils.helper"
local O = require "config.options"

return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-refactor",
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/playground",
        },
        -- event = "CursorHold",
        keys = {
            {
                "<leader>gt", "",
                desc = "Go to current function name",
                noremap = false,
                callback = function()
                    vim.api.nvim_exec("normal [f", false)
                    vim.fn.search("(", "c")
                    vim.api.nvim_exec("normal B", false)
                end,
            },
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        node_incremental = "v",
                        node_decremental = "V",
                    },
                },
                highlight = {
                    enable = true,
                    disable = function(lang, bufnr)
                        local has_semantic_highlight = {"c"}
                        if vim.g.enable_semantic_highlight then
                            if table.contains(has_semantic_highlight, vim.bo.filetype) then
                                return true
                            end
                        end
                        return vim.api.nvim_buf_line_count(bufnr) > 10000
                    end,
                    additional_vim_regex_highlighting = true,
                },
                textobjects = {
                    select = {
                        enable = true,
                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>a"] = "@parameter.inner",
                        },
                        swap_previous = {
                            ["<leader>A"] = "@parameter.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]f"] = "@function.outer",
                            ["]j"] = "@loop.outer",
                        },
                        goto_next_end = {
                            ["]F"] = "@function.outer",
                        },
                        goto_previous_start = {
                            ["[f"] = "@function.outer",
                            ["[j"] = "@loop.outer",
                        },
                        goto_previous_end = {
                            ["[F"] = "@function.outer",
                        },
                    },
                },
                refactor = {
                    highlight_definitions = {
                        enable = false,
                    },
                    highlight_current_scope = {
                        enable = false,
                    },
                    smart_rename = {
                        enable = true,
                        keymaps = {
                            smart_rename = "grr",
                        },
                    },
                    navigation = {
                        enable = true,
                        keymaps = {
                            goto_definition = "<a-)>", --- alt-shift-0
                            -- goto_next_usage = "<a-*>", --- alt-shift-8
                            -- goto_previous_usage = "<a-#>", --- alt-shlft-3
                        },
                    },
                },
            })
        end,
    },
    {
        "lewis6991/spellsitter.nvim",
        enabled = function()
            return vim.opt.spell:get()
        end,
    },
    {
        "kdheepak/lazygit.nvim",
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        keys = {
            {
                "<leader>gg", "<cmd>:LazyGit<cr>",
                desc = "LazyGit", noremap = false,
            },
        },
        -- optional for floating window border decoration
        dependencies =  {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim"
        },
        config = function()
            require("telescope").load_extension("lazygit")
        end,
    },
    {
        "tpope/vim-fugitive",
    },
    {
        "github/copilot.vim",
    },
    {
        'echasnovski/mini.nvim',
        config = function()
            local header_art = [[
   _                                _                      
  (_) ___  _ __  _ __  _   _    ___| |__   ___ _ __   __ _ 
  | |/ _ \| '_ \| '_ \| | | |  / __| '_ \ / _ \ '_ \ / _` |
  | | (_) | | | | | | | |_| | | (__| | | |  __/ | | | (_| |
 _/ |\___/|_| |_|_| |_|\__, |  \___|_| |_|\___|_| |_|\__, |
|__/                   |___/                         |___/ 
]]

            -- using the mini plugins
            require('mini.sessions').setup({
                -- Whether to read latest session if Neovim opened without file arguments
                autoread = false,
                -- Whether to write current session before quitting Neovim
                autowrite = false,
                -- Directory where global sessions are stored (use `''` to disable)
                directory = O.sessions_dir, --<"session" subdir of user data directory from |stdpath()|>,
                -- File for local session (use `''` to disable)
                file = '' -- 'Session.vim',
            })

            local starter = require('mini.starter')
            starter.setup({
                -- trigger in one go, if the selected keychar is unique
                evaluate_single = true,
                items = {
                    starter.sections.sessions(7, true),
                    starter.sections.builtin_actions(),
                },
                content_hooks = {
                    starter.gen_hook.indexing('all', { 'Builtin actions' }),
                    starter.gen_hook.aligning('center', 'center'),
                },
                header = header_art,
                footer = '',
            })

            -- -- highlight current indentation level
            -- local indent = require('mini.indentscope')
            -- indent.setup({
            --     draw = {
            --         animation = indent.gen_animation.none(),
            --     }
            -- })

            -- split and join arguments
            local splitjoin = require('mini.splitjoin')
            -- https://github.com/echasnovski/mini.nvim/blob/main/doc/mini-splitjoin.txt
            local gen_hook = splitjoin.gen_hook
            local smart_add_trailing_separator = function(opt)
                return function(split_positions)
                    -- c/cpp does not allow trailing comma, so set to empty char
                    if vim.bo.filetype == "c" then
                        opt.sep = ""
                    end
                    if vim.bo.filetype == "cpp" then
                        opt.sep = ""
                    end
                    gen_hook.add_trailing_separator(opt)(split_positions)
                end
            end
            local add_comma_curly = smart_add_trailing_separator({})
            local del_comma_curly = gen_hook.del_trailing_separator({})
            splitjoin.setup({
                mappings = {
                    toggle = "K",
                },
                split = { hooks_post = { add_comma_curly } },
                join  = { hooks_post = { del_comma_curly } },
            })

            -- extend textobjects
            require('mini.ai').setup({
                -- Next/last variants
                around_next = '',
                inside_next = '',
                around_last = '',
                inside_last = '',
            })

            -- jump to next after search for f/F/t/T
            local jump = require('mini.jump')
            jump.setup({
                -- delay = {
                --     highlight = 0,
                --     idle_stop = 1000,
                -- }
            })
            -- vim.keymap.set("n", "<Esc>", "*", {
            --     desc = "Clear mini.jump",
            --     callback = function()
            --         if jump.state.jumping then
            --             jump.stop_jumping()
            --         end
            --     end
            -- })

            require('mini.surround').setup({
                mappings = {
                    add = 'ys', -- Add surrounding in Normal and Visual modes
                    delete = 'ds', -- Delete surrounding
                    find = '', -- Find surrounding (to the right)
                    find_left = '', -- Find surrounding (to the left)
                    highlight = '', -- Highlight surrounding
                    replace = 'cs', -- Replace surrounding
                    update_n_lines = '', -- Update `n_lines`

                    suffix_last = '', -- Suffix to search with "prev" method
                    suffix_next = '', -- Suffix to search with "next" method
                },
                -- Number of lines within which surrounding is searched
                n_lines = 9999,
                search_method = 'cover_or_next',
            })
        end,
    },
    {
        'echasnovski/mini.files',
        version = '*',
        keys = {
            {
                "<leader>e", "<cmd>:lua MiniFiles.open()<cr>",
                desc = "Open Explorer",
                noremap = false,
            },
        },
        opts = {
            mappings = {
                close       = '<ESC>',
                go_in       = 'l',
                go_in_plus  = '<CR>',
                go_out      = 'h',
                go_out_plus = '',
                mark_goto   = "'",
                mark_set    = 'm',
                reset       = '<BS>',
                reveal_cwd  = '@',
                show_help   = 'g?',
                synchronize = '=',
                trim_left   = '<',
                trim_right  = '>',
              },
        },
    },
}
