return {
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({
        options = {
          transparent = false,
          terminal_colors = true,
          dim_inactive = false,
          module_default = true,
        }
      })
      vim.cmd("colorscheme github_light")
    end,
  },
}
