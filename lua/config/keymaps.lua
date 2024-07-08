-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local H = require "utils.helper"

local function map(mode, lhs, rhs, opts)
    local keys = require("lazy.core.handler").handlers.keys
    ---@cast keys LazyKeysHandler
    -- do not create the keymap if a lazy keys handler exists
    if not keys.active[keys.parse({
        lhs,
        mode = mode,
    }).id] then
        opts = opts or {}
        vim.keymap.set(mode, lhs, rhs, opts)
    end
end

map({"n", "x"}, ";", ":", {
    -- silent = false,
})
map("n", "*", "<cmd>keepjumps normal!*N<cr>", {
    noremap = true,
    desc = "Search forward and highlight current first",
})
map("n", "#", "<cmd>keepjumps normal!#N<cr>", {
    desc = "Search backward and highlight current first",
})

map("n", "<C-;>", "<cmd>:noh<cr>", {
    desc = "Clear highlight",
})

map("n", "<C-s>", "<cmd>:w<cr>", {
    desc = "Copy to system clipboard",
})

map("i", "<C-s>", "<esc>:w<cr>a", {
    desc = "Copy to system clipboard",
})

map("v", "<C-c>", "\"*y", {
    desc = "Copy to system clipboard",
})

map("i", "<C-v>", "<esc>\"*p", {
    desc = "Paste from system clipboard",
})
map("c", "<C-v>", "<c-r>*", {
    desc = "Paste from system clipboard",
})

-- Session Manager
if H.has_plugin "neovim-session-manager" then
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
if H.has_plugin "smart-splits.nvim" then
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
    if H.is_windows() then
        map("n", "<A-Up>", "", {
            callback = function()
                require("smart-splits").resize_up()
            end,
            desc = "Resize split up",
        })
        map("n", "<A-Down>", "", {
            callback = function()
                require("smart-splits").resize_down()
            end,
            desc = "Resize split down",
        })
        map("n", "<A-Left>", "", {
            callback = function()
                require("smart-splits").resize_left()
            end,
            desc = "Resize split left",
        })
        map("n", "<A-Right>", "", {
            callback = function()
                require("smart-splits").resize_right()
            end,
            desc = "Resize split right",
        })
    else
        map("n", "<D-Up>", "", {
            callback = function()
                require("smart-splits").resize_up()
            end,
            desc = "Resize split up",
        })
        map("n", "<D-Down>", "", {
            callback = function()
                require("smart-splits").resize_down()
            end,
            desc = "Resize split down",
        })
        map("n", "<D-Left>", "", {
            callback = function()
                require("smart-splits").resize_left()
            end,
            desc = "Resize split left",
        })
        map("n", "<D-Right>", "", {
            callback = function()
                require("smart-splits").resize_right()
            end,
            desc = "Resize split right",
        })
    end
    map("n", "<C-j>", "<C-w>j", {
        desc = "Move to below split",
    })
    map("n", "<C-k>", "<C-w>k", {
        desc = "Move to above split",
    })
end

map("n", "<C-h>", "<C-w>h", {
    desc = "Move to left split",
})
map("n", "<C-l>", "<C-w>l", {
    desc = "Move to right split",
})
