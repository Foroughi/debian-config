

local plugins = {

    --Thems
    require("plugin-noice"),
    --require("plugin-theme"),
    --require("plugin-dressing"),
    --require("plugin-catppuccin"),

    --Editor
    --require("plugin-gitsign"),
    --require("plugin-bufferline"),
    --require("plugin-indent"),

    --Tools
    --require("plugin-notify"),
    --require("plugin-lualine"),
    --require("plugin-telescope"),
    --require("plugin-dev-container"),
    --require("plugin-which-key"),
    --require("plugin-terminal"),
    --require("plugin-mason"),

    -- LSP
    --require("plugin-lsp"),
    --require("plugin-treesitter"),
    --require("plugin-trouble"),
    
    
}


local getPlugins = function()

    local configs = {};

    for  _, plugin in ipairs(plugins)  do

        table.insert(configs, plugin.config)

    end

    return configs
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)


require("lazy").setup(getPlugins())

for  _, plugin in ipairs(plugins)  do

    plugin.setup()

end


