return {

    config = {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                command_palette = false, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = true, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false, -- add a border to hover docs and signature help
            },
          views = {
              cmdline_popup = {
                position = {
                  row = "50%",
                  col = "50%",
                },
                size = {
                  width = 60,
                  height = "auto",
                },
              },
              popupmenu = {
                relative = "editor",
                position = {
                  row = 8,
                  col = "50%",
                },
                size = {
                  width = 160,
                  height = 10,
                },
                border = {
                  style = "rounded",
                  padding = { 5, 5 },
                },
                win_options = {
                  winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                },
              },
            },
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

                
           
        })
    end

}
