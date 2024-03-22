return {

    config = {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 0
        end,
        config = true,
        opts = {

            key_labels = {

                ["<leader>"] = "SPACE",
                ["<space>"] = "SPACE",
                ["<esc>"] = "ESCAPE",
                ["<CR>"] = "ENTER",
                ["<bs>"] = "BASKSPACE",
                ["<tab>"] = "TAB",
            },
            window = {
                border = "single",        -- none, single, double, shadow
                position = "bottom",      -- bottom, top
                margin = { 0, 1, 1, 0.75 },  -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
                padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
                winblend = 5,             -- value between 0-100 0 for fully opaque and 100 for fully transparent
                zindex = 1000,            -- positive value to position WhichKey above other floating windows.
            },
            layout = {
                height = { min = 4, max = 25 }, -- min and max height of the columns
                width = { min = 100, max =  100 }, -- min and max width of the columns
                spacing = 0,                    -- spacing between columns
                align = "center",                 -- align columns left, center or right
            },
            ignore_missing = false,

        }
    },
    setup = function()
        local wk = require("which-key")

        wk.register({      
            c = "Copy",
            C = "Copy line",
            v = "Paste",
            x = "Cut",
            X = "Cut line",                   
            f = {
                name = "Files",
                f = { "<cmd>Telescope find_files<cr>", "Find a file in current directory" },
                b = { "<cmd>Telescope buffers<cr>", "List of opened windows" },
                g = { "<cmd>Telescope live_grep<cr>", "Find in files" },
                d = { "<cmd>Telescope diagnostics<cr>", "View LSP diagnostics" },
                h = { "<cmd>Telescope help_tags<cr>", "Help" }
            },
            w = {
                name = "Window navigation",
                q = { "<cmd>q<cr>", "Close current window" },
                Q = { "<cmd>quitall<cr>", "Close all" },
                n = {
                    name = "New file",
                    n = { "<cmd>new<cr>", "Create new window" },
                    v = { "<cmd>vnew<cr>", "Create new window vertically" },
                    h = { "<cmd>hnew<cr>", "Create new window horizontally" },
                },
                s = {
                    name = "Split",
                    v = { "<cmd>vsplit<cr>", "Split vertically" },
                    h = { "<cmd>split<cr>", "Split horizontally" }
                },
                r = {
                    name = "Resize",
                    h = { "<cmd>vert resize -10<cr>", "Resize to left" },
                    l = { "<cmd>vert resize +10<cr>", "Resize to right" },
                    j = { "<cmd>resize +5<cr>", "Resize to down" },
                    k = { "<cmd>resize -5<cr>", "Resize to up" },
                },
                h = { "<cmd>wincmd h<cr>", "Move to right window" },
                l = { "<cmd>wincmd l<cr>", "Move to left window" },
                j = { "<cmd>wincmd j<cr>", "Move to down window" },
                k = { "<cmd>wincmd k<cr>", "Move to top window" },
            },
            t = {
                name = "Tab navigation",
                n = { "<cmd>tabnew<cr>", "New tab" },
                q = { "<cmd>q<cr>", "Close current tab" },
                Q = { "<cmd>quitall<cr>", "Close all" },
                h = { "<cmd>tabprev<cr>", "Move to previouse tab" },
                l = { "<cmd>tabnext<cr>", "Move to next tab" },
                --["<pageup>"] = { "<cmd>tabfirst<cr>", "Move to first tab" },
                --["<pagedown>"] = { "<cmd>tablast<cr>", "Move to last tab" },
            },
        }, { prefix = "<leader>" })
    end

}
