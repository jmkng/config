Log = {}

function _G.add_to_log(msg)
    table.insert(Log, {
        timestamp = vim.uv.hrtime() / 1e6,
        message = msg,
    })
end

function _G.print_log()
    for _, entry in ipairs(Log) do
        print(string.format("[%0.6f] %s", entry.timestamp, entry.message))
    end
end

function _G.clear_log()
    Log = {}
end
