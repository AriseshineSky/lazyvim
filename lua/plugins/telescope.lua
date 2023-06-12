return {
    cmd = "Telescope",
    keys = {
        { "<C-p>", ":Telescope find_files<CR>", desc = "find files" },
    },
    "nvim-telescope/telescope.nvim",
    tag = "-1.1.1",
    -- or                              , branch = '-1.1.1',
    dependencies = { "nvim-lua/plenary.nvim" },
}
