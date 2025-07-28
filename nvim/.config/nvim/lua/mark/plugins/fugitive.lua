return {
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = {"fugitive"}
  },
}


--vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git status" })
--vim.keymap.set("n", "<leader>gd", ":Gdiffsplit<CR>", { desc = "Git diff" })
--vim.keymap.set("n", "<leader>gb", ":G blame<CR>", { desc = "Git blame" })
