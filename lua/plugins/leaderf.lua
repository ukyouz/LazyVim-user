return {
  {
    "Yggdroot/LeaderF",
    event = "VimEnter",
    keys = {
        {
            "<leader>fd", "",
            desc = "Find gtags Definition",
            noremap = false,
            callback = function()
                local cword = vim.fn.expand('<cword>')
                vim.api.nvim_exec(string.format("Leaderf! gtags -d %s --auto-jump", cword), true)
            end,
        },
        {
            "<leader>p", "<cmd>:LeaderfFile<cr>",
            desc = "Find Files", noremap = false,
        },
        {
            "<leader>ft", "<cmd>:LeaderfTag<cr>",
            desc = "Find Tags", noremap = false,
        },
        {
            "<leader>fg", "<cmd>:Leaderf gtags<cr>",
            desc = "Find Gtags", noremap = false,
        },
        {
            "<leader>fr", "",
            desc = "Find References",
            noremap = false,
            callback = function()
                local cword = vim.fn.expand('<cword>')
                vim.api.nvim_exec(string.format("Leaderf! gtags -r %s --auto-jump", cword), true)
            end,
        },
        {
            "<leader>fG", "<cmd>:Leaderf! gtags --recall <cr>",
            desc = "Resume Gtags window", noremap = false,
        },
        {
            "<leader>fs", "<cmd>:LeaderfBufTag<cr>",
            desc = "Find buffer Symbol (Leaderf)", noremap = false,
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
            "<leader>fc", "",
            desc = "Find current word (Leaderf rg)",
            noremap = false,
            callback = function()
                local cword = vim.fn.expand('<cword>')
                vim.api.nvim_exec(string.format("Leaderf! rg -s -w -F %s ", cword), true)
            end,
        },
        {
            "<F4>", "<cmd>:Leaderf! rg --next<cr>",
            desc = "Goto Next rg result",
            noremap = false,
            silent = true,
        },
        {
            "<S-F4>", "<cmd>:Leaderf! rg --prev<cr>",
            desc = "Goto Next rg result",
            noremap = false,
            silent = true,
        },
        {
            "<leader>fR", "<cmd>:Leaderf! rg --recall <cr>",
            desc = "Resume Rg window", noremap = false,
        },
        {
            "<leader>f\\", "<cmd>:LeaderfRgInteractive<cr>",
            desc = "Interactive search", noremap = false,
        },
    },
    init = function()
        vim.g.Lf_Gtagslabel = "native-pygments"
        vim.g.Lf_GtagsGutentags = true
        vim.g.Lf_GtagsAutoGenerate = false
        vim.g.Lf_GtagsAutoUpdate = false

        vim.g.Lf_ShortcutF = "<leader>ff"  -- to avoid <leader>f open LeaderfFile picker
        vim.g.Lf_ShortcutB = "<leader>fb"  -- to avoid <leader>b open LeaderBuffer picker

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
            Gtags = 0,
        }

        vim.g.Lf_CtagsFuncOpts = {
            python = "--langmap=Python:.py.pyw",
            c = "--excmd=number --fields=+nS"
        }
    end,
  },
}
