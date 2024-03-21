return {

    config = {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    },
    setup = function()
        require("noice").setup({
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                },
            },
          
            cmdline_popup = {
              position = {
                row = 0,
                col = "60%",
              },
              size = {
                width = 160,
                height = "auto",
              },
            },
            views = {
              cmdline_popup = {
                border = {
                  style = "none",
                  padding = { 2, 3 },
                },
                filter_options = {},
                win_options = {
                  winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                },
              },
            },
            popupmenu = {
              enabled = true, -- enables the Noice popupmenu UI
              --backend = "cmp", -- backend to use to show regular cmdline completions
              relative = "editor",
              position = {
                row = 8,
                col = "150%",
              },
              size = {
                width = 160,
                height = 10,
              },
              border = {
                style = "rounded",
                padding = { 10, 10 },
              },
              
            },
            
        })
    end

}
