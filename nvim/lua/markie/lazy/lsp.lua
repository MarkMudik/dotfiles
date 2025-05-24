return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {},
      })

      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Enable snippet support
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- clangd setup
      lspconfig.clangd.setup({
        capabilities = capabilities,
        cmd = {
          "/usr/bin/clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=never",
        },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        single_file_support = true,
      })

      -- html setup
      lspconfig.html.setup({
        capabilities = capabilities,
        cmd = { "vscode-html-language-server", "--stdio" },
        filetypes = { "html" },
        init_options = {
          configurationSection = { "html", "css", "javascript" },
          embeddedLanguages = {
            css = true,
            javascript = true,
          },
        },
        root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
        settings = {},
      })

      -- Keymaps for LSP
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show Documentation" })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
      })
    end,
  },
}
