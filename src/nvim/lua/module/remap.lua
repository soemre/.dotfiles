-- Movement
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Alignment
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- Util
vim.keymap.set("x", "<leader>p", "\"_dp")
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")

vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Terminal
vim.keymap.set({ "n", "v" }, "<C-\">", function() vim.cmd("! $TERM") end)
