local nvim_lsp = require "lspconfig"
local coq = require "coq"

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- local cmp = require "cmp"
-- local lspkind = require "lspkind"
-- 
-- cmp.setup({
--   snippet = {
--     expand = function(args)
--       vim.fn["vsnip#anonymous"](args.body)
--     end,
--   },
--   mapping = {
--     ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping.complete(),
--     ['<C-e>'] = cmp.mapping.close(),
--     ['<CR>'] = cmp.mapping.confirm({ select = true }),
--     ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })
--   },
--   sources = {
--     { name = 'nvim_lsp' },
--     { name = 'vsnip' },
--     { name = 'buffer' },
--     { name = 'treesitter' },
--   },
--   formatting = {
--     format = lspkind.cmp_format({with_text = true, maxwidth = 20})
--   },
--   completion = {
--     keyword_length = 2
--   }
-- })

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require "cmp_nvim_lsp".update_capabilities(capabilities)

nvim_lsp.vuels.setup(coq.lsp_ensure_capabilities({
  -- capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "vls" },
  filetypes = { "vue" },
  root_dir = nvim_lsp.util.root_pattern("package.json", "vue.config.js"),
  init_options = {
    config = {
      css = {},
      emmet = {},
      html = {
        suggest = {}
      },
      javascript = {
        format = {}
      },
      stylusSupremacy = {},
      typescript = {
        format = {}
      },
      vetur = {
        completion = {
          autoImport = true,
          tagCasing = "kebab",
          useScaffoldSnippets = false
        },
        format = {
          defaultFormatter = {
            js = "prettier",
            ts = "prettier"
          },
          defaultFormatterOptions = {},
          scriptInitialIndent = false,
          styleInitialIndent = false
        },
        useWorkspaceDependencies = false,
        validation = {
          script = true,
          style = true,
          template = true
        }
      }
    }
  },
}))

local path_to_elixirls = vim.fn.expand("~/elixir-ls/release/language_server.sh")

nvim_lsp.elixirls.setup({
  cmd = {path_to_elixirls},
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    elixirLS = {
      dialyzerEnabled = false,
      fetchDeps = false
    }
  }
})

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    print(server.name)
    local opts = {}
    opts.capabilities = capabilities
    opts.on_attach = on_attach
    opts.flags = {
      debounce_text_changes = 150,
    }

    -- Elixirls
    if server.name == "elixirls" then
      opts.settings = {
        elixirLS = {
          -- dialyzerEnabled = true,
          fetchDeps = true
        }
      }
    end

    server:setup(coq.lsp_ensure_capabilities(opts))
    vim.cmd [[ do User LspAttachBuffers ]]
end)

require("null-ls").config({
    sources = { require("null-ls").builtins.formatting.stylua }
})

require("lspconfig")["null-ls"].setup({
    on_attach = on_attach
})

nvim_lsp.efm.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = {"elixir"}
})
