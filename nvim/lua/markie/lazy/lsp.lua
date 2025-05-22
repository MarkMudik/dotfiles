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
      -- Setup Mason (LSP installer)
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {}, -- Disable auto-install
      })

      -- Setup LSP for C++ (clangd)
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

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

      -- Keymaps for LSP
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show Documentation" })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",       -- Optional: Snippet engine
      "saadparwaiz1/cmp_luasnip",-- Optional: Snippet completions
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- Optional: Snippets
          { name = "buffer" },
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
      })
    end,
  },
}
