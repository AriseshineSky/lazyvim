return {
    cmd = "Telescope",
    keys = {
        { "<C-p>", ":Telescope find_files<CR>", desc = "find files" },
        { "e", "<Down>", desc = "Next item" },
        { "u", "<Up>", desc = "Previous item" },
    },
    "nvim-telescope/telescope.nvim",
    tag = "-1.1.1",
    dependencies = { "nvim-lua/plenary.nvim" },
}
