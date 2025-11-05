vim.o.statusline = "%f %m %r %= %l:%c %p%% %#StatusLineQuickfix#%{v:lua.set_quickfix_status()}%* %#StatusLineUltrasight#%{v:lua.set_ultrasight_status()}%*"

_G.set_quickfix_status = function()
    local qf = vim.fn.getqflist()
    local count = 0
    for _, item in ipairs(qf) do
        if item.valid == 1 then count = count + 1 end
    end

    if count > 0 then return '[QF: ' .. count .. ']' end
    return ''
end

_G.set_ultrasight_status = function()
    local ultrasight = require('ultrasight')
    if ultrasight.enabled then return "[ULTRA]" else return "" end
end

vim.api.nvim_create_autocmd("User", {
  pattern = "UltrasightMode",
  callback = function()
    vim.cmd("redrawstatus")
  end,
})
