local config = require("hlterm").get_config()

local function source_lines(lines)
    local f = config.tmp_dir .. "/duckdb.sql"
    vim.fn.writefile(lines, f)
    require("hlterm").send_cmd("duckdb", '. ' .. f ..  )
end

require("hlterm").set_ft_opts("sql", {
    nl = "\n",
    app = "duckdb",
    quit_cmd = ".exit",
    source_fun = source_lines,
    send_empty = false,
    syntax = { match = {}, keyword = {} },
})

vim.api.nvim_buf_set_keymap(
    0,
    "n",
    config.mappings.start,
    "<Cmd>lua require('hlterm').start_app('duckdb')<CR>",
    {}
)
