return {
  {
    'ThePrimeagen/harpoon',
    config = function()

      require('harpoon').setup({
        global_settings = {
          save_on_toggle = true,
          save_on_exit = true,
        },
      })

      local map = vim.keymap.set
      map('n', '<leader>mm', require('harpoon.mark').add_file)   -- Add file to marks
      map('n', '<leader><enter>', require('harpoon.ui').toggle_quick_menu)  -- Toggle Harpoon UI
    end,
  },
}
