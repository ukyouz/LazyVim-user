return {
    {
        'echasnovski/mini.nvim',
        config = function()
            local header_art = [[
       _       ____   _   _  U _____ u _   _     ____
    U |"| u U /"___| |'| |'| \| ___"|/| \ |"| U /"___|u
   _ \| |/  \| | u  /| |_| |\ |  _|" <|  \| |>\| |  _ /
  | |_| |_,-.| |/__ U|  _  |u | |___ U| |\  |u | |_| |
   \___/-(_/  \____| |_| |_|  |_____| |_| \_|   \____|
    _//      _// \\  //   \\  <<   >> ||   \\,-._)(|_
   (__)     (__)(__)(_") ("_)(__) (__)(_")  (_/(__)__)
]]

            -- using the mini plugins
            require('mini.sessions').setup({
                -- Whether to read latest session if Neovim opened without file arguments
                autoread = false,
                -- Whether to write current session before quitting Neovim
                autowrite = false,
                -- Directory where global sessions are stored (use `''` to disable)
                directory =  vim.fn.stdpath("data") .. "/sessions", --<"session" subdir of user data directory from |stdpath()|>,
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

            -- highlight current indentation level
            local indent = require('mini.indentscope')
            indent.setup({
                draw = {
                    animation = indent.gen_animation.none(),
                }
            })

            -- split and join arguments
            require('mini.splitjoin').setup({
                mappings = {
                    toggle = "K",
                }
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
            require('mini.jump').setup({
                delay = {
                    highlight = 0,
                    idle_stop = 10000,
                }
            })
        end,
    },
}