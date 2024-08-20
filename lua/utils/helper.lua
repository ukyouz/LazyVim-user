
local helper = {}

function table.contains(table, element)
    for _, value in pairs(table) do
      if value == element then
        return true
      end
    end
    return false
end

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

function helper.key(key)
    return vim.api.nvim_replace_termcodes(key, true, false, true)
end

function helper.get_visual_selection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg('v')
	vim.fn.setreg('v', {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ''
	end
end

function helper.get_titlestring()
    -- use string literal for titlestring to minimize the performance impact
    local branch = ""
    if helper.is_windows() then
        branch = vim.fn.trim(vim.fn.system('git rev-parse --abbrev-ref HEAD 2> NUL'))
    else
        branch = vim.fn.trim(vim.fn.system('git rev-parse --abbrev-ref HEAD 2> /dev/null'))
    end
    local pwd = vim.fn.getcwd()
    if branch ~= "" then
        return "[" .. branch .. "] " .. pwd
    else
        return pwd
    end
end

return helper
