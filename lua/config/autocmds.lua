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
