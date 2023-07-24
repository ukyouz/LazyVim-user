return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- Setup language servers.
            local lspconfig = require("lspconfig")
            lspconfig.pyright.setup { }
            lspconfig.clangd.setup { }
            lspconfig.intelephense.setup { }

            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            -- vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
            vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = {
                        buffer = ev.buf,
                    }
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
                        buffer = ev.buf,
                        desc = "Goto Declaration",
                    })
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
                        buffer = ev.buf,
                        desc = "Goto Definition",
                    })
                    vim.keymap.set("n", "gR", vim.lsp.buf.references, {
                        buffer = ev.buf,
                        desc = "Goto References",
                    })
                    vim.keymap.set("n", "<leader>lk", vim.lsp.buf.hover, {
                        buffer = ev.buf,
                        desc = "Show hover contents",
                    })
                    vim.keymap.set('n', '<space>ld', vim.diagnostic.open_float, {
                        desc = "Show Diagnostic",
                    })
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {
                        buffer = ev.buf
                    })
                    -- vim.keymap.set("n", "<leader>lk", vim.lsp.buf.signature_help, { buffer = ev.buf, desc =
                    -- "Lsp signature" })
                    -- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, {buffer = ev.buf})
                    -- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, {buffer = ev.buf})
                    -- vim.keymap.set("n", "<space>wl", function()
                    --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    -- end, {buffer = ev.buf})
                    -- vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, {buffer = ev.buf})
                    vim.keymap.set("n", "<space>lr", vim.lsp.buf.rename, {
                        buffer = ev.buf,
                        desc = "Rename variable by LSP",
                    })
                    -- vim.keymap.set({
                    --     "n",
                    --     "v",
                    -- }, "<space>ca", vim.lsp.buf.code_action, {buffer = ev.buf})
                    -- vim.keymap.set("n", "gr", vim.lsp.buf.references, {buffer = ev.buf})
                    vim.keymap.set("n", "<space>lf", function()
                        vim.lsp.buf.format {
                            async = true,
                        }
                    end, {
                        buffer = ev.buf,
                        desc = "Lsp Format buffer",
                    })
                end,
            })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            -- "hrsh7th/cmp-nvim-lsp-signature-help",
            -- "hrsh7th/cmp-path",
        },
        event = "BufReadPost",
        opts = function(_, opts)
            local cmp = require "cmp"
            -- opts.enabled = function()
            --     if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" then return false end
            --     return vim.g.cmp_enabled
            -- end
            -- opts.window = {
            --     completion = cmp.config.window.bordered(),
            --     documentation = cmp.config.window.bordered(),
            -- }
            local lspkind = require("lspkind")
            opts.formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol", -- show only symbol annotations
                    maxwidth = 33, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                }),
            }
            opts.mapping = {
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                ["<C-Space>"] = cmp.mapping.confirm({
                    select = false,
                }),
            }
            opts.sources = cmp.config.sources({
                -- {
                --     name = "nvim_lsp_signature_help",
                -- },
                {
                    name = "nvim_lsp",
                },
                {
                    name = "buffer",
                },
            },{
                {
                    name = "buffer",
                },
            })
            return opts
        end,
    },
    {
        "onsails/lspkind.nvim",
        event = "LspAttach",
    },
}
