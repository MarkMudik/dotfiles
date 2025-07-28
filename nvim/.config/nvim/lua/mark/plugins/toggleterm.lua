return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<c-\>]], -- Ctrl+\ to toggle terminal
        on_create = function()
          vim.opt.foldcolumn = "0"
          vim.opt.signcolumn = "no"
        end,
        hide_numbers = true,
        shade_filetypes = {},
        autochdir = false,
        highlights = {
          Normal = {
            guibg = "none",
          },
          NormalFloat = {
            link = 'Normal'
          },
          FloatBorder = {
            guifg = "#ffffff",
            guibg = "none",
          },
        },
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        persist_mode = true,
        direction = 'float',
        close_on_exit = true,
        shell = vim.o.shell,
        auto_scroll = true,
        float_opts = {
          border = 'curved',
          width = 120,
          height = 30,
          winblend = 3,
        },
        winbar = {
          enabled = false,
          name_formatter = function(term)
            return term.name
          end
        },
      })

      -- ⬇ This part is AFTER the setup call, but inside config = function()
      local Terminal = require("toggleterm.terminal").Terminal
      local bottom_term = Terminal:new({
        direction = "horizontal",
        hidden = true,
        size = 15,
      })

      vim.keymap.set("n", "<leader>t", function()
        bottom_term:toggle()
      end, { desc = "Toggle bottom terminal" })
    end,
  },
}
