
local helper = {}

function helper.has_plugin (plugin)
    local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
    return lazy_config_avail and lazy_config.plugins[plugin] ~= nil
end

function helper.is_windows ()
    local path_sep = package.config:sub(1,1)
    return path_sep == "\\"
end

return helper