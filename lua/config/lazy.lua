local H = require("utils.helper")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.mapleader = " "
vim.g.maplocalleader = " "
if H.is_windows() then
    -- try fix: windows copy/paste is slow
    -- https://github.com/neovim/neovim/issues/21739
    vim.g.clipblard = {
        name = 'win32yank_nvim',
        copy = {
           ['+'] = 'win32yank.exe -i --crlf',
           ['*'] = 'win32yank.exe -i --crlf',
         },
        paste = {
           ['+'] = 'win32yank.exe -o --lf',
           ['*'] = 'win32yank.exe -o --lf',
        },
        cache_enabled = 1,
    }
    vim.g.python3_host_prog = vim.fn.expand("$LOCALAPPDATA/Programs/Python/Python310/python.exe")
else
    vim.g.python3_host_prog = vim.fn.expand("/Library/Frameworks/Python.framework/Versions/3.10/bin/python3.10")
end

-- require("lazy").setup({
--   spec = {
--     { import = "plugins" },
--   },
-- })

require("lazy").setup({
    spec = {
        -- add LazyVim and import its plugins
        -- { "LazyVim/LazyVim", import = "lazyvim.plugins" },
        -- import any extras modules here
        -- { import = "lazyvim.plugins.extras.lang.typescript" },
        -- { import = "lazyvim.plugins.extras.lang.json" },
        -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
        -- import/override with your plugins
        {
            import = "plugins",
        },
    },
    defaults = {
        -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
        -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
        lazy = false,
        -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
        -- have outdated releases, which may break your Neovim install.
        version = false, -- always use the latest git commit
        -- version = "*", -- try installing the latest stable version for plugins that support semver
    },
    -- install = { colorscheme = { "tokyonight", "habamax" } },
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                "gzip",
                "matchit",
                -- "matchparen",
                -- "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})

require("config.keymaps")
require("config.autocmds")
require("config.options")
