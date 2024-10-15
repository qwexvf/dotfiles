return {
    'saghen/blink.cmp',
    lazy = false, -- lazy loading handled internally
    dependencies = 'rafamadriz/friendly-snippets',
    build = 'cargo build --release',
    config = function()
        require("blink.cmp").setup({
            opts = {
                highlight = {
                    use_nvim_cmp_as_default = true,
                },
                nerd_font_variant = 'mono',
                -- experimental auto-brackets support
                accept = { auto_brackets = { enabled = true } },
                -- experimental signature help support
                trigger = { signature_help = { enabled = true } },
                keymap = {
                    show = '<C-space>',
                    hide = '<C-e>',
                    accept = '<Tab>',
                    select_prev = { '<Up>', '<C-p>' },
                    select_next = { '<Down>', '<C-n>' },
                }
            }
        })
    end,
}
