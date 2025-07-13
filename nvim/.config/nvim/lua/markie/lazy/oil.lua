return {
    {
        'stevearc/oil.nvim',
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        lazy = false,

        config = function()
            require("oil").setup({
                view_options = {
                    show_hidden = true,
                },
            })

            vim.keymap.set("n", "<leader>pv", "<cmd>Oil<Cr>", { desc = "Open file explorer" })
        end,
    },
}
