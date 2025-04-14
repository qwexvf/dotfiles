return {
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",
  version = "*",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = "default" },

    appearance = {
      nerd_font_variant = "mono",
    },

    signature = {
      enabled = true,
      window = {
        show_documentation = true,
      },
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    -- Blink.cmp uses a Rust fuzzy matcher by default for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" },

    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
      },
      menu = {
        draw = {
          columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
        },
      },
    },
  },
  opts_extend = { "sources.default" },
}
