return {
    {
        "junegunn/fzf.vim",
        dependencies = {
            "junegunn/fzf",
        },
        keys = {
            {"<leader>p", "<cmd>:FzfGFiles<cr>",
                desc = "Fzf Files",
                noremap = false,
            },
            {
                "<leader>ft", "<cmd>:FzfBTags<cr>",
                desc = "Find buffer Tag", noremap = false,
            },
            {
                "<leader>fl", "<cmd>:FzfLines<cr>",
                desc = "Find buffer Lines", noremap = false,
            },
            {
                "<leader>fc", ":<c-r>=printf('FzfRg %s', expand('<cword>'))<cr><cr>",
                desc = "Find Current word (rg)",
                noremap = false,
            },
            {
                "<S-F5>", function()
                    local cmd = "gtags --incremental"
                    print(vim.fn.printf("running [%s]...", cmd))
                    vim.fn.jobstart(
                        cmd,
                        {
                            on_exit = function(jobid, exit_code, evt_type) 
                                if exit_code == 0 then
                                    print(vim.fn.printf("[%s] done.", cmd))
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
        init = function()
            vim.cmd("let $FZF_DEFAULT_OPTS = '--reverse'")
            vim.g.fzf_layout = {
                window = {
                    width = 0.8,
                    height = 1
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
    event = "VimEnter",
    keys = {
        {
            "<leader>fd", "<Plug>LeaderfGtagsDefinition",
            desc = "Find gtags Definition",
            noremap = false,
        },
        -- {
        --     "<leader>p", "<cmd>:LeaderfFile<cr>",
        --     desc = "Find Files", noremap = false,
        -- },
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
        vim.g.Lf_GtagsGutentags = false
        vim.g.Lf_GtagsAutoGenerate = true
        vim.g.Lf_GtagsAutoUpdate = true
        vim.g.Lf_GtagsStoreInProject = 1  -- temp workaround for telescope-gtags to work

        vim.g.Lf_ShortcutF = ""  -- to avoid <leader>f open LeaderfFile picker
        vim.g.Lf_ShortcutB = "<leader>fb"  -- to avoid <leader>b open LeaderBuffer picker
        vim.g.Lf_NeedCacheTime = 1
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
