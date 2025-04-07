return {

    config = {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
          { "zbirenbaum/copilot.lua"},
          { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        event = "VeryLazy"
    },
    setup = function()

        local chat = require("CopilotChat")
        
        chat.setup({
            question_header = "## Ali ",
            answer_header = "## Copilot ",
            error_header = "## Error ",
            prompts = {
              -- Code related prompts
              Explain = "Please explain how the following code works.",
              Review = "Please review the following code and provide suggestions for improvement.",
              Tests = "Please explain how the selected code works, then generate unit tests for it.",
              Refactor = "Please refactor the following code to improve its clarity and readability.",
              FixCode = "Please fix the following code to make it work as intended.",
              FixError = "Please explain the error in the following text and provide a solution.",
              BetterNamings = "Please provide better names for the following variables and functions.",
              Documentation = "Please provide documentation for the following code.",
              SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
              SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
              -- Text related prompts
              Summarize = "Please summarize the following text.",
              Spelling = "Please correct any grammar and spelling errors in the following text.",
              Wording = "Please improve the grammar and wording of the following text.",
              Concise = "Please rewrite the following text to make it more concise.",
            },
            model =  "gpt-4o" , -- or claude-3.7-sonnet",
            window = {
                layout = 'vertical', -- 'vertical', 'horizontal', 'float', 'replace', or a function that returns the layout
                width = 0.25, -- fractional width of parent, or absolute width in columns when > 1
                height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
                -- Options below only apply to floating windows
                relative = 'editor', -- 'editor', 'win', 'cursor', 'mouse'
                border = 'single', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
                row = nil, -- row position of the window, default is centered
                col = nil, -- column position of the window, default is centered
                title = 'Copilot', -- title of chat window
                footer = nil, -- footer of chat window
                zindex = 1, -- determines if window is on top or below other floating windows
            },
            show_help = false,
            auto_follow_cursor = false,
            insert_at_end = true,
            highlight_selection = false,
            mappings = {
                submit_prompt = {
                  normal = '<CR>',
                  insert = '<CR>',
                },
                close = {
                  normal = '<Esc>',
                  insert = '<Esc>',
                },
            }
        })

        vim.api.nvim_create_user_command("CopilotSetup", function(args)
            require("copilot").setup({})
        end, { nargs = "*", range = true })
        
        vim.api.nvim_create_user_command("CopilotChatOutline", function(args)
            local current_buf = vim.api.nvim_get_current_buf()

            chat.reset()
            chat.set_selection(vim.api.nvim_get_current_buf(), 1 ,vim.api.nvim_buf_line_count(current_buf))
            chat.open();
            vim.cmd("startinsert")
        end, { nargs = "*", range = true })

        vim.api.nvim_create_user_command("CopilotChatInline", function(args)

            local cursor_pos = vim.api.nvim_win_get_cursor(0)
            local line_number = cursor_pos[1]

            chat.reset()
            chat.set_selection(vim.api.nvim_get_current_buf(), line_number,line_number)
            -- Setup the inline chat window
            chat.open({
                window = {
                    layout = "float",
                    relative = "cursor",
                    width = 0.5,
                    height = 0.4,
                    row = 1,
                },
                highlight_selection = true,
                auto_follow_cursor = false,
            });
            vim.cmd("startinsert")
        end, { nargs = "*", range = true })
    end
}
