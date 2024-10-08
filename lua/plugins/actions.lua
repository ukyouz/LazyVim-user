local H = require "utils.helper"
local O = require "config.options"

return {
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
        -- add surround movement
        "machakann/vim-sandwich",
    },
    {
        -- better comment action
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
    },
    {
        -- better . repeat action
        "tpope/vim-repeat",
    },
    {
        -- add common `[`, `]` movement
        "tpope/vim-unimpaired",
    },
    {
        -- add indent as a textobject
        "michaeljsmith/vim-indent-object",
    },
    {
        "mg979/vim-visual-multi",
        config = function()
            vim.g.VM_theme = "codedark"
        end,
    },
    {
        "ThePrimeagen/refactoring.nvim",
        -- vim.iter is only available after NVIM 0.10.1
        -- temporarily stick to this version unless NVIM 0.10.1 is stable enough for me
        commit = "d0721874",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
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
                mode = { "n" },
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
                filter = {
                    fzf = {
                        extra_opts = {'--bind', 'ctrl-o:toggle-all,' .. O.fzf_binding, '--prompt', '(Fzf)? '},
                    }
                }
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
}