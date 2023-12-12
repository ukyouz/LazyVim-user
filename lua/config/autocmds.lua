-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local H = require "utils.helper"

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
        events = {"BufEnter", "CursorHold", "CursorHoldI", "FocusGained"},
        opts = {
            pattern = {"*"},
            desc = "Ensure to load the latest file revision",
            command = "if mode() != 'c' | silent! checktime | endif",
        },
    },
})

H.augroup("disableLspSemanticHL", {
    {
        events = {"BufEnter"},
        opts = {
            callback = function(args)
                -- Hide all semantic highlights
                for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
                    vim.api.nvim_set_hl(0, group, {})
                end
            end,
        }
    }
})

H.augroup("highlightTrailingWhitespace", {
    {
        events = {"VimEnter", "WinEnter"},
        opts = {
            callback = function(args)
                if vim.bo.filetype == "aerial" then
                    return
                end
                -- :match ExtraWhitespace /\s\+$/
                vim.cmd([[highlight ExtraWhitespace ctermfg=red guifg=red ctermbg=red guibg=red]])
                vim.cmd([[match ExtraWhitespace /\s\+$/]])
            end
        },
    }
})

-- https://superuser.com/questions/815416/hitting-enter-in-the-quickfix-window-doesnt-work
-- " In the quickfix window, <CR> is used to jump to the error under the
-- " cursor, so undefine the mapping there.
-- autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
H.augroup("FixQuickFixEnter", {
    {
        events = {"BufReadPost"},
        opts = {
            pattern = {"quickfix"},
            command = "nnoremap <buffer> <CR> <CR>",
        },
    }
})