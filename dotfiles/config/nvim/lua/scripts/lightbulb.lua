local M = {}
local text = ""
local symbol = ""

function M.update()
    local context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }
    local params = require("vim.lsp.util").make_range_params()
    params.context = context
    vim.lsp.buf_request(
        0, 'textDocument/codeActions', params, function(_, _, result)
            if result then
                text = symbol
            else
                text = ''
            end
        end
    )
end

function M.get_text()
    return text
end

return M
