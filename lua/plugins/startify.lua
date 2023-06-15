return {
    "mhinz/vim-startify",
    init = function()
        -- vim.g.startify_commands = {
        --     ":call LoadProjectVimrc()",
        -- }
        vim.g.startify_enable_special = 0
        vim.g.startify_relative_path = 1
        vim.g.startify_change_to_vcs_root = 1
        vim.g.startify_session_autoload = 1
        -- vim.g.startify_session_dir = ".vscode/.session"
        vim.g.startify_session_persistence = 1
        vim.g.startify_session_delete_buffers = 1
        vim.g.startify_lists = {
            -- { type='dir',       header={'   Current Directory:'. getcwd()} },
            {
                type = "bookmarks",
                header = {
                    "   Bookmarks",
                },
            },
            {
                type = "sessions",
                header = {
                    "   Sessions",
                },
            },
            {
                type = "files",
                header = {
                    "   Files",
                },
            },
        }
        vim.g.startify_bookmarks = {
        }

        vim.g.startify_custom_header = {
            "________      ______                                  ______                      ",
            "______(_)________  /____________________  __    _________  /____________________ _",
            "_____  /_  __ \\_  __ \\_  __ \\_  __ \\_  / / /    _  ___/_  __ \\  _ \\_  __ \\_  __ `/",
            "____  / / /_/ /  / / /  / / /  / / /  /_/ /     / /__ _  / / /  __/  / / /  /_/ / ",
            "___  /  \\____//_/ /_//_/ /_//_/ /_/_\\__, /______\\___/ /_/ /_/\\___//_/ /_/_\\__, /  ",
            "/___/                              /____/_/_____/                        /____/   ",
        }
    end,
}
