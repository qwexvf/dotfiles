return {
    "stevearc/conform.nvim",
    lazy = false,
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                -- Conform will run multiple formatters sequentially
                python = { "isort", "black" },
                -- You can customize some of the format options for the filetype (:help conform.format)
                rust = { "rustfmt", lsp_format = "fallback" },
                -- Conform will run the first available formatter
                javascript = { "prettierd", "prettier", stop_after_first = true },
            },
        })

        vim.api.nvim_create_user_command("Format", function(args)
            local range = nil
            if args.count ~= -1 then
                local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                range = {
                    start = { args.line1, 0 },
                    ["end"] = { args.line2, end_line:len() },
                }
            end
            conform.format({ async = true, lsp_format = "fallback", range = range })
        end, { range = true })
    end
}
