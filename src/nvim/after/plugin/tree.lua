vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup()
local api = require("nvim-tree.api")


vim.keymap.set(
    { "n", "i" },
    "<C-b>",
    function()
        api.tree.toggle({
            path = "<args>",
            find_file = false,
            update_root = false,
            focus = false,
        })
    end
)
