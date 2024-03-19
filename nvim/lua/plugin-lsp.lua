local setup_tools = function()
    local cmp = require('cmp')

    cmp.setup {
        sources = {
            { name = 'nvim_lsp' },
            { name = "buffer" },
        },
        mapping = cmp.mapping.preset.insert({  
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm {
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
          },
        formatting = {
            fields = { "kind", "abbr" },
            format = function(_, vim_item)
              vim_item.kind = cmp_kinds[vim_item.kind] or ""
              return vim_item
            end,
          },
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
