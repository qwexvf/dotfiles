local config = function()
  local nvim_lsp = require "lspconfig"

  nvim_lsp.lua_ls.setup {
    settings = {
      Lua = {
        diagnostics = {
          enable = true,
          globals = { "vim" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  }

  nvim_lsp.graphql.setup {
    cmd = { "bun", "run", "graphql-lsp", "server", "-m", "stream" },
  }

  nvim_lsp.biome.setup {
    -- get config file from current project root directory
    cmd = { "bun", "run", "biome", "lsp-proxy" },
    root_dir = nvim_lsp.util.root_pattern "biome.json",
  }

  -- Enable rust_analyzer
  nvim_lsp.rust_analyzer.setup {
    cmd = { "rustup", "run", "stable", "rust-analyzer" },
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        -- enable clippy diagnostics on save
        checkOnSave = {
          command = "clippy",
        },
        imports = {
          granularity = {
            group = "module",
          },
          prefix = "self",
        },
        cargo = {
          buildScripts = {
            enable = true,
          },
        },
        procMacro = {
          enable = true,
        },
      },
    },
  }

  nvim_lsp.denols.setup {
    init_options = {
      lint = true,
      unstable = true,
      suggest = {
        imports = {
          hosts = {
            ["https://deno.land"] = true,
            ["https://cdn.nest.land"] = true,
            ["https://crux.land"] = true,
          },
        },
      },
    },
    root_dir = function(path)
      local marker = require "climbdir.marker"
      return require("climbdir").climb(
        path,
        marker.one_of(
          marker.has_readable_file "deno.json",
          marker.has_readable_file "deno.jsonc",
          marker.has_readable_file "import_maps.json",
          marker.has_directory "denops"
        ),
        {
          halt = marker.one_of(marker.has_readable_file "package.json", marker.has_directory "node_modules"),
        }
      )
    end,
  }

  nvim_lsp.gleam.setup {}

  vim.lsp.enable "zls"
end

return {
  "neovim/nvim-lspconfig",
  config = config,
  lazy = false,
}
