local H = require "utils.helper"
local O = require "config.options"

return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        enabled = function()
            return vim.version().minor >= 9
        end,
        keys = {
            {
                "<leader>p", "<cmd>:Telescope find_files file_encoding=" .. O.encoding .. "<cr>",
                desc = "Telescope Files",
            },
            -- {
            --     "<leader>ft", ":Telescope lsp_workspace_symbols file_encoding=" .. O.encoding .. " query=",
            --     desc = "Telescope query workspace Tags",
            -- },
            {
                "<leader>fc",
                function()
                    local tb = require('telescope.builtin')
                    local cword = vim.fn.expand("<cword>")
                    if vim.fn.mode() == "v" then
                        cword = vim.fn.escape(H.get_visual_selection(), "[]()*+.$^")
                    end
                    vim.opt.hlsearch = true
                    vim.fn.setreg("/", cword)
                    tb.live_grep({
                        default_text = cword,
                        file_encoding = O.rg_encoding,
                        only_sort_text = true,
                        initial_mode = "normal",
                        additional_args = {"--max-columns=500"},
                        previewer = false,
                    })
                    -- tb.grep_string({
                    --     file_encoding = O.rg_encoding,
                    --     only_sort_text = true,
                    --     initial_mode = "normal",
                    --     additional_args = {"--max-columns=500"},
                    -- })
                end,
                desc = "Telescope Current word",
                mode = {"n", "v"},
            },
            {
                "<leader>fk", "<cmd>:Telescope keymaps file_encoding=" .. O.encoding .. "<cr>",
                desc = "Telescope Keymaps",
            },
            -- {
            --     "<leader>fg", "<cmd>:Telescope live_grep file_encoding=" .. O.encoding .. "<cr>",
            --     desc = "Telescope Grep (Live)",
            -- },
            {
                "<leader>fb", "<cmd>:Telescope buffers file_encoding=" .. O.encoding .. "<cr>",
                desc = "Telescope Buffers",
            },
            {
                "<leader>fh", "<cmd>:Telescope help_tags file_encoding=" .. O.encoding .. "<cr>",
                desc = "Telescope Helps",
            },
            {
                "<leader>fk", "<cmd>:Telescope keymaps file_encoding=" .. O.encoding .. "<cr>",
                desc = "Telescope Keymaps",
            },
            -- {
            --     "<leader>fi", "<cmd>:Telescope lsp_incoming_calls file_encoding=" .. O.encoding .. "<cr>",
            --     desc = "Telescope Incoming calls (LSP)",
            -- },
            -- {
            --     "<leader>fr", ":Telescope lsp_references file_encoding=" .. O.encoding .. " query=",
            --     desc = "Telescope References (LSP)",
            -- },
            {
                "<leader>fl", ":Telescope current_buffer_fuzzy_find file_encoding=" .. O.rg_encoding .. "<cr>",
                desc = "Telescope buffer Lines",
            },
            {
                "<leader>fw", ":Telescope live_grep only_sort_text=true file_encoding=" .. O.rg_encoding .. " default_text=",
                desc = "Telescope Live grep",
            },
            {
                "<leader>fT", "<cmd>:Telescope treesitter file_encoding=" .. O.encoding .. "<cr>",
                desc = "Telescope Treesitter",
            },
            {
                "<leader>fR", "<cmd>:Telescope resume<cr>",
                desc = "Telescope Resume",
            },
            {
                "<leader>fq", "<cmd>:Telescope quickfixhistory<cr>",
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
                        sessions_dir = O.sessions_dir,
                    }
                },
                preview = {
                    treesitter = false,
                },
                defaults = {
                    sorting_strategy = "ascending",
                    layout_strategy = "center",
                    borderchars = {
                        prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
                        results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
                        preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                    },
                    layout_config = {
                        center = {
                            prompt_position = "top",
                            -- height = 0.99,
                            width = 0.85,
                            anchor = "N",
                            -- mirror = true,
                        },
                        vertical = {
                            prompt_position = "top",
                            height = 0.99,
                            -- width = 0.8,
                            anchor = "N",
                            mirror = true,
                            -- preview_cutoff = 0, -- always show preview event at small visible region
                        },
                    },
                    path_display = {
                        -- "smart",
                        -- "shorten",  -- foldername with only the first char
                        "truncate",
                        "filename_first",
                    },
                    winblend = 10, -- avoid picker being too transparent
                    mappings = {
                        n = {
                            ["p"] = layout.toggle_preview,
                            ["<C-p>"] = layout.toggle_preview,
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-d>"] = actions.results_scrolling_down,
                            ["<C-u>"] = actions.results_scrolling_up,
                            ["<space>"] = actions.toggle_selection,
                            ["<Esc>"] = function(_bufnr)
                                actions.close(_bufnr)
                                -- clear highlight when cancel
                                vim.cmd("nohlsearch")
                            end,
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
                                -- clear highlight when cancel
                                vim.cmd("nohlsearch")
                            end,
                        },
                    }
                },
                pickers = {
                    buffers = {
                        mappings = {
                            n = {
                                ["<M-d>"] = false, -- change delete_buffer keymap to `d`
                                ["d"] = actions.delete_buffer,
                            },
                        },
                    },
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
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        enabled = function()
            return vim.version().minor >= 9
        end,
        build = "make",
        config = function()
            -- To get fzf loaded and working with telescope, you need to call
            -- load_extension, somewhere after setup function:
            require('telescope').load_extension('fzf')
        end
    },
    {
        "ukyouz/persistence.nvim",
        branch = "dev",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        opts = {
            dir = O.sessions_dir, -- directory where session files are saved
            branch = false, -- use git branch in session name
            -- open a file from context-menu actually triggered open folder and file
            -- so set to 3 to avoid the case too.
            need = 1, -- avoid too much sessions for editing single file
            path_sep = "+", -- path separator
        },
        config = function(_, opts)
            require("persistence").setup(opts)
            H.augroup("CleanUpWindow", {
                {
                    events = { "User" },
                    opts = {
                        pattern = { "PersistenceSavePre" },
                        callback = function()
                            if vim.fn.exists(':NERDTreeClose') > 0 then
                                vim.cmd("NERDTreeClose")
                            end
                            if vim.fn.exists(':AerialClose') > 0 then
                                vim.cmd("AerialClose")
                            end
                            if H.has_plugin "rgflow" then
                                require("rgflow").close()
                            end
                            vim.cmd("cclose")
                        end,
                    }
                }
            })
        end,
    },
    {
        "ukyouz/telescope_sessions_picker.nvim",
        branch = "dev/improve_restore_session",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        keys = {
            {
                "<leader>fS", "<cmd>:Telescope sessions_picker<cr>",
                desc = "Telescope Session",
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
        enabled = vim.fn.executable('gtags') and vim.fn.executable("git"),
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        ft = O.gtags_filetyps,
        keys = {
            {
                "<leader>fg", "<cmd>:Telescope gtags only_sort_text=true file_encoding=" .. O.encoding .. "<cr>",
                desc = "Telescope Gtag symbols",
            },
            {
                "<leader>fd", "<cmd>:Telescope gtags_definitions file_encoding=" .. O.encoding .. " initial_mode=normal<cr>",
                desc = "Telescope Definitions (Gtags)",
            },
            {
                "<leader>fr", "<cmd>:let @/='\\<'.expand('<cword>').'\\>' | set hlsearch | Telescope gtags_references file_encoding=" .. O.encoding .. " initial_mode=normal<cr>",
                desc = "Telescope References (Gtags)",
            },
            {
                "<leader>fs", "<cmd>:let @/='\\<'.expand('<cword>').'\\>' | set hlsearch | Telescope gtags_symbol_usages file_encoding=" .. O.encoding .. " initial_mode=normal<cr>",
                desc = "Telescope Symbols (Gtags)",
            },
            {
                "<leader>ft", "<cmd>:Telescope gtags_buffer_symbols only_sort_text=true file_encoding=" .. O.encoding .. "<cr>",
                desc = "Telescope buffer Tags (Gtags)",
            },
            {
                "<S-F5>", function()
                    local pwd, dbpath = require('telescope-gtags').setup_env()
                    local cmd = "git ls-files --recurse-submodules | gtags --incremental --file -"
                    if H.is_windows() then
                        os.execute("mkdir " .. dbpath)
                    else
                        os.execute("mkdir -p " .. dbpath)
                    end
                    print(vim.fn.printf("running [%s]...", cmd))
                    vim.fn.jobstart(
                        cmd,
                        {
                            on_exit = function(jobid, exit_code, evt_type)
                                os.remove(dbpath .. "/GPATH")
                                os.remove(dbpath .. "/GRTAGS")
                                os.remove(dbpath .. "/GTAGS")
                                if exit_code == 0 then
                                    print(vim.fn.printf("[%s] done.", cmd))
                                    os.rename("GPATH", dbpath .."/GPATH")
                                    os.rename("GRTAGS", dbpath .."/GRTAGS")
                                    os.rename("GTAGS", dbpath .."/GTAGS")
                                else
                                    os.remove("GPATH")
                                    os.remove("GRTAGS")
                                    os.remove("GTAGS")
                                    print(vim.fn.printf("[%s] Error %d! Tag files are removed.", cmd, exit_code))
                                end
                            end,
                            on_stdout = function(cid, data, name)
                                print(data[1])
                            end,
                            on_stderr = function(cid, data, name)
                                if data[1] ~= "" then
                                    print("Error:" .. data[1])
                                end
                            end,
                        }
                    )
                end,
            },
        },
        opts = {
            storeInProjectFolder = false,
            dbPath = vim.fn.stdpath("data") .. "/gtags",
        },
        config = function(_, opts)
            -- if H.has_plugin "telescope.nvim" then
            --     require('telescope').load_extension('gtags')
            -- end
            require('telescope-gtags').setup(opts)

            H.augroup("AutoUpdateGtags", {
                {
                    events = {"BufWritePost", "FileChangedShellPost"},
                    opts = {
                        callback = function(args)
                            if not table.contains(O.gtags_filetyps, vim.bo[args.buf].filetype) then
                                return
                            end
                            -- args.match stores fullpath of the file
                            local cmd = {"gtags", "--single-update", args.match}
                            -- print(vim.fn.printf("running [%s]...", cmd))
                            vim.fn.jobstart(
                                cmd,
                                {
                                    on_exit = function(jobid, exit_code, evt_type)
                                        if exit_code == 0 then
                                            -- print(vim.fn.printf("[%s] done.", cmd))
                                        else
                                            print(vim.fn.printf("[%s] Error!", cmd))
                                        end
                                    end,
                                    on_stdout = function(cid, data, name)
                                        print(data[1])
                                    end,
                                    on_stderr = function(cid, data, name)
                                        if data[1] ~= "" then
                                            print("Error:" .. data[1])
                                        end
                                    end,
                                }
                            )
                        end,
                    },
                },
            })
        end,
    },
    {
        "junegunn/fzf.vim",
        enabled = false,
        dependencies = {
            "junegunn/fzf",
        },
        -- keys = {
        --     {"<leader>p", "<cmd>:FzfGFiles<cr>",
        --         desc = "Fzf Files",
        --         noremap = false,
        --     },
        --     {
        --         "<leader>ft", "<cmd>:FzfBTags<cr>",
        --         desc = "Find buffer Tag", noremap = false,
        --     },
        --     {
        --         "<leader>fl", "<cmd>:FzfLines<cr>",
        --         desc = "Find buffer Lines", noremap = false,
        --     },
        --     {
        --         "<leader>fc", ":<c-r>=printf('FzfRg %s', expand('<cword>'))<cr><cr>",
        --         desc = "Find Current word (rg)",
        --         noremap = false,
        --     },
        -- },
        init = function()
            vim.cmd("let $FZF_DEFAULT_OPTS = '--reverse --bind=" .. O.fzf_binding .. "'")
            vim.g.fzf_layout = {
                window = {
                    width = 0.8,
                    height = 0.99,
                }
            }
            vim.g.fzf_vim = {
                command_prefix = "Fzf",
                preview_window = {},
                -- tags_command = "gtags -i",
                -- grep_multi_line = 1,
            }
        end,
    },
  {
    "Yggdroot/LeaderF",
    enabled = false,
    event = "VimEnter",
    keys = {
        {
            "<leader>fd", "<Plug>LeaderfGtagsDefinition",
            desc = "Find gtags Definition",
            noremap = false,
        },
        {
            "<leader>p", "<cmd>:LeaderfFile<cr>",
            desc = "Find Files", noremap = false,
        },
        {
            "<leader>ft", "<cmd>:Leaderf gtags --current-buffer<cr>",
            desc = "Find buffer Tag", noremap = false,
        },
        {
            "<leader>fg", "<cmd>:Leaderf gtags<cr>",
            desc = "Find Gtags", noremap = false,
        },
        {
            "<F3>", "<cmd>:Leaderf gtags --next<cr>",
            desc = "Find Gtags", noremap = false,
        },
        {
            "<S-F3>", "<cmd>:Leaderf gtags --previous<cr>",
            desc = "Find Gtags", noremap = false,
        },
        {
            "<leader>fG", "<cmd>:Leaderf! gtags --recall <cr>",
            desc = "Resume Gtags window", noremap = false,
        },
        {
            "<leader>fr", "<Plug>LeaderfGtagsReference",
            desc = "Find define References",
            noremap = false,
        },
        {
            "<leader>fs", "<Plug>LeaderfGtagsSymbol",
            desc = "Find Symbol references", noremap = false,
        },
        {
            "<leader>fl", "<cmd>:LeaderfLine<cr>",
            desc = "Find buffer Lines", noremap = false,
        },
        {
            "<leader>fw", "<cmd>:Leaderf! rg<cr>",
            desc = "Find Words (Live rg)",
            noremap = false,
        },
        {
            "<leader>fc", ":<c-r>=printf('Leaderf! rg -s -w -F %s ', expand('<cword>'))<cr><cr>",
            desc = "Find Current word (rg)",
            noremap = false,
        },
        {
            "<leader>fR", "<cmd>:Leaderf! rg --recall <cr>",
            desc = "Resume Rg window", noremap = false,
        },
        {
            "<F4>", "<cmd>:Leaderf! rg --next<cr>",
            desc = "Goto next rg result",
            noremap = false,
            silent = true,
        },
        {
            "<S-F4>", "<cmd>:Leaderf! rg --prev<cr>",
            desc = "Goto prev rg result",
            noremap = false,
            silent = true,
        },
        {
            "<S-F5>", "<cmd>:Leaderf gtags --update<cr>",
            desc = "Update Gtags",
            noremap = false,
            silent = false,
        },
        {
            "<leader>f\\", "<cmd>:LeaderfRgInteractive<cr>",
            desc = "Interactive search", noremap = false,
        },
        {
            "<leader>fb", "<cmd>:LeaderfBuffer<cr>",
            desc = "Find Buffers"
        },
    },
    init = function()
        -- vim.g.Lf_Gtagslabel = "native-pygments"
        vim.g.Lf_GtagsGutentags = 0
        vim.g.Lf_GtagsAutoGenerate = 0
        vim.g.Lf_GtagsAutoUpdate = 0
        vim.g.Lf_GtagsSource = 2  -- use Lf_GtagsfileCmd
        vim.g.Lf_GtagsStoreInProject = 1  -- temp workaround for telescope-gtags to work
        vim.g.Lf_GtagsfilesCmd = {
            ['.sln'] = 'dir /B /S *.c /S *.C /S *.cpp /S *.CPP /S *.h /S *.hh',
        }
        vim.g.Lf_RgConfig = {
            -- '--glob="*.{c,C,cpp,CPP,h,hh,xml,bas}"',
            '--encoding=sjis',
            '--trim',
            '--color=never',
            -- '--no-config',
        }

        vim.g.Lf_ShortcutF = "<leader>p"  -- to avoid <leader>f open LeaderfFile picker
        vim.g.Lf_ShortcutB = "<leader>fb"  -- to avoid <leader>b open LeaderBuffer picker
        vim.g.Lf_NeedCacheTime = 1
        vim.g.Lf_RecurseSubmodules = 1
        vim.g.Lf_PopupColorscheme = 'onedark'
        -- vim.g.Lf_StlColorscheme = 'onedark'
        vim.g.Lf_WindowPosition = 'popup'
        vim.g.Lf_WindowHeight = 0.4
        vim.g.Lf_PopupHeight = 0.4
        vim.g.Lf_PopupWidth = 0.8
        vim.g.Lf_PopupPosition = {1, 0}
        vim.g.Lf_PopupPreviewPosition = 'bottom'
        vim.g.Lf_DefaultMode = 'NameOnly'
        vim.g.Lf_PreviewInPopup = 1
        vim.g.Lf_ShowDevIcons = 1
        vim.g.Lf_JumpToExistingWindow = 0
        vim.g.Lf_StlSeparator = { left = "", right = "" }
        vim.g.Lf_NormalMap = {
            _ =     {{"<C-j>", "j"},
                      {"<C-k>", "k"}
                     },
            File=   {{"<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>'}},
            Buffer= {{"<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<CR>'}},
            Mru=    {{"<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<CR>'}},
            Tag=    {{"<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<CR>'}},
            Gtags=  {{"<ESC>", ':exec g:Lf_py "gtagsExplManager.quit()"<CR>'}},
            BufTag= {{"<ESC>", ':exec g:Lf_py "bufTagExplManager.quit()"<CR>'}},
            Function= {{"<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<CR>'}},
            Rg=     {{"<ESC>", ':exec g:Lf_py "rgExplManager.quit()"<CR>'}},
            Line=   {{"<ESC>", ':exec g:Lf_py "lineExplManager.quit()"<CR>'}},
            History={{"<ESC>", ':exec g:Lf_py "historyExplManager.quit()"<CR>'}},
            Help=   {{"<ESC>", ':exec g:Lf_py "helpExplManager.quit()"<CR>'}},
            Self=   {{"<ESC>", ':exec g:Lf_py "selfExplManager.quit()"<CR>'}},
            Colorscheme= {{"<ESC>", ':exec g:Lf_py "colorschemeExplManager.quit()"<CR>'}},
        }
        vim.g.Lf_PreviewScrollStepSize = 10
        vim.g.Lf_PreviewResult = {
            File = 0,
            Buffer = 0,
            Mru = 1,
            Tag = 0,
            BufTag = 1,
            Function = 0,
            Line = 1,
            Colorscheme = 1,
            Rg = 0,
            Gtags = 1,
        }

        vim.g.Lf_CtagsFuncOpts = {
            python = "--langmap=Python:.py.pyw",
            c = "--excmd=number --fields=+nS"
        }
    end,
  },
}
