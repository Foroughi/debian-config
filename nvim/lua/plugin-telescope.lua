return {

    config = {
        {
            'nvim-telescope/telescope.nvim',
            tag = '0.1.6',
            -- or                              , branch = '0.1.x',
            dependencies = { 
                'nvim-lua/plenary.nvim'
                
            }
        }
    },
    setup = function()

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        vim.keymap.set('n', '<leader>fd', builtin.lsp_workspace_diagnostics, {})

        
    end

}
