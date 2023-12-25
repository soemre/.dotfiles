-- Color Setup
vim.cmd.highlight("SignColumn guibg=NONE")

local function changeColor(group, color, singleColor)
    local bgColor = color

    if singleColor == false then
        bgColor = "NONE"
    end

    vim.cmd.highlight(string.format("%s guifg=%s guibg=%s", group, color, bgColor))
end

changeColor("GitGutterAdd", "Green")
changeColor("GitGutterChange", "Orange")

-- Doing this for Deleted lines make it confusing
changeColor("GitGutterDelete", "Red", false)
