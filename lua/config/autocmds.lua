-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local H = require "utils.helper"
local O = require "config.options"

H.augroup("numbertoggle", {
    {
        events = {"BufEnter", "FocusGained", "InsertLeave"},
        opts = {
            nested = true,
            pattern = {"*"},
            command = "set relativenumber cursorline",
        },
    },
    {
        events = {"BufLeave" ,"FocusLost", "InsertEnter"},
        opts = {
            nested = true,
            pattern = {"*"},
            command = "set norelativenumber nocursorline",
        },
    },
})

H.augroup("autoreload", {
    {
        events = {"BufEnter", "FocusGained"},
        opts = {
            pattern = {"*"},
            desc = "Ensure to load the latest file revision",
            command = "if mode() != 'c' | silent! checktime | endif",
        },
    },
})

-- H.augroup("disableLspSemanticHL", {
--     {
--         events = {"BufEnter"},
--         opts = {
--             callback = function(args)
--                 -- Hide all semantic highlights
--                 for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
--                     vim.api.nvim_set_hl(0, group, {})
--                 end
--             end,
--         }
--     }
-- })

H.augroup("highlightTrailingWhitespace", {
    {
        events = {"VimEnter", "WinEnter", "BufReadPost"},
        opts = {
            callback = function(args)
                if vim.bo[args.buf].buftype == "nofile" then
                    return
                end
                if vim.bo[args.buf].buftype == "quickfix" then
                    return
                end
                -- :match ExtraWhitespace /\s\+$/
                vim.cmd([[highlight ExtraWhitespace ctermfg=red guifg=red ctermbg=red guibg=red]])
                vim.cmd([[match ExtraWhitespace /\s\+$/]])
            end
        },
    }
})

-- update window title (may required slow system call)
-- only at certain events are triggered
H.augroup("UpdateTitleString", {
    {
        events = {"FocusGained", "FileChangedShellPost", "DirChanged", "TermLeave"},
        opts = {
            callback = function()
                vim.opt.titlestring = H.get_titlestring()
            end,
        },
    }
})


H.augroup("ResetStatusColumnFormat", {
    {
        events = { "FileType" },
        opts = {
            pattern = { "qf" },
            desc = "Ensure statuscolumn format consistency",
            callback = function(args)
                vim.cmd("setlocal statuscolumn=")
            end,
        },
    },
})