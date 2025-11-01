vim.o.statusline = "%f %m %r %= %l:%c %p%% %{v:lua.set_status_line()}"

_G.set_status_line = function()
    local ultrasight = require('ultrasight')
    if ultrasight.enabled then return "[ULTRA OUT]" else return "" end
end

vim.api.nvim_create_autocmd("User", {
  pattern = "UltrasightMode",
  callback = function()
    vim.cmd("redrawstatus")
  end,
})
