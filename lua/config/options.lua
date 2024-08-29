-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local H = require "utils.helper"
local O = {
    statuscolumn = " %=%{v:relnum?v:relnum:v:lnum} %s",
    fontsize = H.is_windows() and 10 or 12,
}

vim.opt.autoindent=true
vim.opt.autoread=true
vim.opt.cursorline=true
-- vim.opt.clipboard+=unnamedplus
vim.opt.expandtab=true
vim.opt.fixendofline=false
vim.opt.formatoptions="qj" -- -=tc
if H.is_windows() then
    vim.opt.guifont = "Fira Code Retina:h" .. O.fontsize
    vim.opt.guifontwide = "メイリオ"
    vim.opt.fileencodings = "cp932,euc-jp,utf-8"
else
    vim.opt.guifont = "FiraCode Nerd Font Mono:h" .. O.fontsize
end
vim.opt.hlsearch=true
vim.opt.incsearch=true
-- vim.opt.lazyredraw=true
vim.opt.linespace=2
vim.opt.list=true
vim.opt.listchars="tab:⭲ ,trail:·,extends:…,precedes:…,nbsp:×"
vim.opt.mouse="a"
vim.opt.number=true
-- vim.opt.path+=**
vim.opt.scrolloff=0
vim.opt.shiftwidth=4
vim.opt.shortmess="filnxtToOFat"  -- += at
vim.opt.showcmd=false  -- don't show keystroke in statusline
vim.opt.signcolumn="yes"
vim.opt.softtabstop=4
vim.opt.splitbelow=true
vim.opt.splitright=true
vim.opt.tabstop=4
vim.opt.termguicolors = vim.api.nvim_eval("has('gui_vimr')") == 1 or H.is_windows()
vim.opt.title=true
vim.opt.titlestring = H.get_titlestring()
vim.opt.updatetime=300
vim.opt.wrap=false
vim.opt.wrapscan=false
vim.opt.statuscolumn=O.statuscolumn

-- Turn backup off
vim.opt.backup=false
vim.opt.wb=false
vim.opt.swapfile=false
vim.opt.hidden=true

if vim.fn.executable("rg") then
    vim.opt.grepprg = "rg --vimgrep --smart-case --hidden"
    vim.opt.grepformat = "%f:%l:%c:%m"
end

-- improve quickfix layout
function _G.qftf(info)
    local items
    local ret = {}
    -- The name of item in list is based on the directory of quickfix window.
    -- Change the directory for quickfix window make the name of item shorter.
    -- It's a good opportunity to change current directory in quickfixtextfunc :)
    --
    -- local alterBufnr = fn.bufname('#') -- alternative buffer is the buffer before enter qf window
    -- local root = getRootByAlterBufnr(alterBufnr)
    -- vim.cmd(('noa lcd %s'):format(fn.fnameescape(root)))
    --
    if info.quickfix == 1 then
        items = vim.fn.getqflist({id = info.id, items = 0}).items
    else
        items = vim.fn.getloclist(info.winid, {id = info.id, items = 0}).items
    end
    local limit = 31
    local fnameFmt1, fnameFmt2 = '%-' .. limit .. 's', '…%.' .. (limit - 1) .. 's'
    local validFmt = '%s|%5d|%s %s'
    for i = info.start_idx, info.end_idx do
        local e = items[i]
        local fname = ''
        local str
        if e.valid == 1 then
            if e.bufnr > 0 then
                fname = vim.fn.bufname(e.bufnr)
                if fname == '' then
                    fname = '[No Name]'
                else
                    fname = fname:gsub('^' .. vim.env.HOME, '~')
                end
                -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
                if #fname <= limit then
                    fname = fnameFmt1:format(fname)
                else
                    fname = fnameFmt2:format(fname:sub(1 - limit))
                end
            end
            local lnum = e.lnum > 99999 and -1 or e.lnum
            -- local col = e.col > 999 and -1 or e.col
            local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()
            str = validFmt:format(fname, lnum, qtype, e.text)
        else
            str = e.text
        end
        table.insert(ret, str)
    end
    return ret
end
vim.o.qftf = '{info -> v:lua._G.qftf(info)}'

return O