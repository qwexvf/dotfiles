local function deno_root_dir(bufnr, on_dir)
  local marker = require "climbdir.marker"
  local path = vim.api.nvim_buf_get_name(bufnr)

  if path == "" then
    return
  end

  local root = require("climbdir").climb(
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

  if root then
    on_dir(root)
  end
end

local function configure_and_enable(name, cfg)
  if cfg then
    vim.lsp.config(name, cfg)
  end

  vim.lsp.enable(name)
end

local config = function()
  configure_and_enable("lua_ls", {
    root_markers = { ".luarc.json", ".luarc.jsonc", ".stylua.toml", "stylua.toml", ".git" },
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
  })

  configure_and_enable("biome", {
    cmd = { "bun", "run", "biome", "lsp-proxy" },
    root_markers = { "biome.json" },
  })

  -- Elixir LSP - only starts in projects with mix.exs
  -- Set ELIXIR_LS_PATH env var or place elixir-ls in PATH
  local elixir_ls = vim.fn.exepath("elixir-ls") ~= "" and "elixir-ls"
    or vim.fn.exepath("lexical") ~= "" and "lexical"
    or vim.env.ELIXIR_LS_PATH

  if elixir_ls then
    vim.lsp.config("elixir", {
      cmd = { elixir_ls },
      root_markers = { "mix.exs", "mix.lock" },
      filetypes = { "elixir", "eelixir", "heex", "surface" },
    })
    vim.lsp.enable("elixir", true)
  end

  configure_and_enable("rust_analyzer", {
    cmd = { "rustup", "run", "stable", "rust-analyzer" },
    root_markers = { "Cargo.toml", "Cargo.lock" },
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
  })

  configure_and_enable("denols", {
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
    root_dir = deno_root_dir,
  })

  -- Gleam LSP - only starts in Gleam projects
  vim.lsp.config("gleam", {
    root_markers = { "gleam.toml" },
  })
  vim.lsp.enable("gleam")

  -- Zig LSP - only starts in Zig projects
  vim.lsp.config("zls", {
    root_markers = { "build.zig", "build.zig.zon" },
  })
  vim.lsp.enable("zls")
end

return {
  "neovim/nvim-lspconfig",
  config = config,
  lazy = false,
}
