local H = require "utils.helper"

return {
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
