-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local util = require "utils.helper"

local function map(mode, lhs, rhs, opts)
    local keys = require("lazy.core.handler").handlers.keys
    ---@cast keys LazyKeysHandler
    -- do not create the keymap if a lazy keys handler exists
    if not keys.active[keys.parse({
        lhs,
        mode = mode,
    }).id] then
        opts = opts or {}
        opts.silent = opts.silent ~= false
        vim.keymap.set(mode, lhs, rhs, opts)
    end
end

map("n", ";", ":", {
    silent = true,
})
map("n", "*", "<cmd>keepjumps normal!*N<cr>", {
    desc = "Search forward and highlight current first",
})
map("n", "#", "<cmd>keepjumps normal!#N<cr>", {
    desc = "Search backward and highlight current first",
})

map("n", "<C-;>", "<cmd>:noh<cr>", {
    desc = "Clear highlight",
})

-- Session Manager
if util.has_plugin "neovim-session-manager" then
    map("n", "<leader>sl", "<cmd>SessionManager! load_last_session<cr>", {
        desc = "Load last session",
    })
    map("n", "<leader>ss", "<cmd>SessionManager! save_current_session<cr>", {
        desc = "Save this session",
    })
    -- map("n", "<leader>sd", {
    --     "<cmd>SessionManager! delete_session<cr>",
    --     desc = "Delete session",
    -- }
    map("n", "<leader>sf", "<cmd>SessionManager! load_session<cr>", {
        desc = "Search sessions",
    })
    -- map("n", "<leader>s.", {
    --     "<cmd>SessionManager! load_current_dir_session<cr>",
    --     desc = "Load current directory session",
    -- }
end

-- Smart Splits
if util.has_plugin "smart-splits.nvim" then
    map("n", "<C-h>", "", {
        callback = function()
            require("smart-splits").move_cursor_left()
        end,
        desc = "Move to left split",
    })
    map("n", "<C-j>", "", {
        callback = function()
            require("smart-splits").move_cursor_down()
        end,
        desc = "Move to below split",
    })
    map("n", "<C-k>", "", {
        callback = function()
            require("smart-splits").move_cursor_up()
        end,
        desc = "Move to above split",
    })
    map("n", "<C-l>", "", {
        callback = function()
            require("smart-splits").move_cursor_right()
        end,
        desc = "Move to right split",
    })
    map("n", "<C-Up>", "", {
        callback = function()
            require("smart-splits").resize_up()
        end,
        desc = "Resize split up",
    })
    map("n", "<C-Down>", "", {
        callback = function()
            require("smart-splits").resize_down()
        end,
        desc = "Resize split down",
    })
    map("n", "<C-Left>", "", {
        callback = function()
            require("smart-splits").resize_left()
        end,
        desc = "Resize split left",
    })
    map("n", "<C-Right>", "", {
        callback = function()
            require("smart-splits").resize_right()
        end,
        desc = "Resize split right",
    })
else
    map("n", "<C-h>", "<C-w>h", {
        desc = "Move to left split",
    })
    map("n", "<C-j>", "<C-w>j", {
        desc = "Move to below split",
    })
    map("n", "<C-k>", "<C-w>k", {
        desc = "Move to above split",
    })
    map("n", "<C-l>", "<C-w>l", {
        desc = "Move to right split",
    })
    map("n", "<C-Up>", "<cmd>resize -2<CR>", {
        desc = "Resize split up",
    })
    map("n", "<C-Down>", "<cmd>resize +2<CR>", {
        desc = "Resize split down",
    })
    map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", {
        desc = "Resize split left",
    })
    map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", {
        desc = "Resize split right",
    })
end
