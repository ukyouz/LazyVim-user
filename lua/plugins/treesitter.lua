return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-refactor",
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/playground",
        },
        event = "CursorHold",
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
                highlight = {
                    enable = true,
                    -- disable = function(lang, bufnr)
                    --     return vim.api.nvim_buf_line_count(bufnr) > 10000
                    -- end,
                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
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
}
