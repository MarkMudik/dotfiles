return {
    {
        'akinsho/toggleterm.nvim', 
        version = "*", 
        opts = {
            direction = 'horizontal',
            size = 8,
            dir = vim.fn.getcwd(),
        },
        config = function(_, opts)
            require('toggleterm').setup(opts)
            
            vim.keymap.set('n', '<leader>t', '<cmd>ToggleTerm<cr>', { 
                desc = 'Toggle terminal' 
            })
        end
    },
}
