local cmp_kinds = {
  Text = '  ',
  Method = '  ',
  Function = '  ',
  Constructor = '  ',
  Field = '  ',
  Variable = '  ',
  Class = '  ',
  Interface = '  ',
  Module = '  ',
  Property = '  ',
  Unit = '  ',
  Value = '  ',
  Enum = '  ',
  Keyword = '  ',
  Snippet = '  ',
  Color = '  ',
  File = '  ',
  Reference = '  ',
  Folder = '  ',
  EnumMember = '  ',
  Constant = '  ',
  Struct = '  ',
  Event = '  ',
  Operator = '  ',
  TypeParameter = '  ',
}

local setup_tools = function()
    local cmp = require('cmp')

    cmp.setup {
        sources = {
            { name = 'nvim_lsp' },
            { name = "buffer" },
        },
        mapping = cmp.mapping.preset.insert({  
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<Tab>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            },
        }),
        window = {
            completion = {
              winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
              col_offset = -3,
              side_padding = 0,
            },
          }       
    }

    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach-format', { clear = true }),
        -- This is where we attach the autoformatting for reasonable clients
        callback = function(args)
            local client_id = args.data.client_id
            local client = vim.lsp.get_client_by_id(client_id)
            local bufnr = args.buf
            if not client.server_capabilities.documentFormattingProvider then
                return
            end

            local opts = { buffer = bufnr, noremap = true, silent = true }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set('n', '<space>wl', function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
            vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
            vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
          
            vim.api.nvim_create_autocmd('BufWritePre', {

                buffer = bufnr,
                callback = function()
                    if not format_is_enabled then
                        return
                    end
                    vim.lsp.buf.format {
                        async = false,
                        filter = function(c)
                            return c.id == client.id
                        end,
                    }
                end,
            })
        end,
    })
end

return {

    config = {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp"
        }
    },
    setup = function()

        local lspconfig = require('lspconfig')

        local servers = {           
            "tsserver",
            "clangd"
        }


        lspconfig.tsserver.setup {}      
        lspconfig.clangd.setup {
            cmd = { 'clangd', '--background-index', '--compile-commands-dir', 'D:/systemc/excersies/build' },
            init_options = {
                clangdFileStatus = true,
                clangdSemanticHighlighting = true
            },
            filetypes = { 'c', 'cpp', 'h' },
            root_dir = function() vim.fn.getcwd() end,
            settings = {
                ['clangd'] = {
                    ['compilationDatabasePath'] = 'build',
                    ['fallbackFlags'] = { '-std=c++17' }
                }
            }
        }
                       
        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup {
                -- on_attach = my_custom_on_attach,
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            }
        end

        setup_tools();
    end

}
