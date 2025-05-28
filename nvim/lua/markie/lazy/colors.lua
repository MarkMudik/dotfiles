-- cyberdream theme
return {
    {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("cyberdream-light")
        end,
    },
}

--[[ 
-- catppuccin theme
return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("catppuccin")
        end,
    },
}
]]
