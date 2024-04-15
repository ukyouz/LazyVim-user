local H = require "utils.helper"

return {
    {
        "stevearc/oil.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        keys = {
            {"-", "<cmd>Oil<cr>"},
        },
        opts = {
            -- delete_to_trash = true, -- not support in Windows
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                -- ["<C-s>"] = "actions.select_vsplit",
                -- ["<C-h>"] = "actions.select_split",
                -- ["<C-t>"] = "actions.select_tab",
                ["<C-p>"] = "actions.preview",
                ["<C-c>"] = "actions.close",
                ["<C-l>"] = "actions.refresh",
                ["<Left>"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = "actions.tcd",
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["g\\"] = "actions.toggle_trash",
              },
        },
        -- init = function()
        --     require("oil").setup()
        -- end,
    },
    {
        "preservim/nerdtree",
        -- cond = false,
        keys = {
            {"<leader>e", "<cmd>:NERDTreeToggle<cr>"},
        },
        config = function()
            vim.cmd([[
                function! NTreeMapCloseDir()
                    let n = g:NERDTreeFileNode.GetSelected()
                    if n != {} && !n.isRoot()
                        if !n.path.isDirectory || !n.isOpen
                            let p = n.parent
                            call p.close()
                            call b:NERDTree.render()
                            call p.putCursorHere(0,0)
                        else " if the node is a opened dir
                            call n.close()
                            call b:NERDTree.render()
                        endif
                    endif
                endfunction
                function! NTreeMapOpenDir()
                    let n = g:NERDTreeFileNode.GetSelected()
                    if n != {}
                        if n.path.isDirectory
                            call n.open()
                            call b:NERDTree.render()
                        endif
                    endif
                endfunction
            ]])
            vim.fn.NERDTreeAddKeyMap({ key= 'h', callback= 'NTreeMapCloseDir' })
            vim.fn.NERDTreeAddKeyMap({ key= 'l', callback= 'NTreeMapOpenDir' })
        end,
    }
}
