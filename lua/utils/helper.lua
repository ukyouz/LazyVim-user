
local helper = {}

function helper.has_plugin (plugin)
    local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
    return lazy_config_avail and lazy_config.plugins[plugin] ~= nil
end

function helper.is_windows ()
    local path_sep = package.config:sub(1,1)
    return path_sep == "\\"
end

function helper.augroup (group_name, autocmds)
    -- autocmds = list of {
    --     events = {},
    --     opts = {
    --         pattern = {"*"},
    --         desc = "",
    --         command = "",
    --     },
    -- }
    local group = vim.api.nvim_create_augroup(group_name, {
        clear = true,
    })
    for _, autocmd in pairs(autocmds) do
        local opts = autocmd["opts"]
        opts["group"] = group
        vim.api.nvim_create_autocmd(autocmd["events"], opts)
    end
end

return helper
