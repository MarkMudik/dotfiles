vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set({ "n", "v" }, "gl", "$", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "gh", "0", { noremap = true, silent = true })
