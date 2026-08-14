local M = {}

M.setup = function()
  local original_diagnostics_handler = vim.lsp.handlers["textDocument/publishDiagnostics"]

  local otter_diagnostics_filter = function(err, result, ctx, config)
    if not result or not result.diagnostics then
      return
    end

    local bufnr = vim.uri_to_bufnr(result.uri)

    if bufnr then
      local bufinfo = vim.fn.getbufinfo(bufnr)[1]
      local name = bufinfo.name

      if name:match("%.otter%.lua$") then
        local filtered_diagnostics = {}
        local ignored_diagnostics = {
          "Unexpected <exp> .",
          "<name> expected.",
          'Missed symbol `"`.',
          "Miss symbol `,` or `;` .",
          "<field> expected.",
        }

        for _, diagnostic in ipairs(result.diagnostics) do
          if not vim.tbl_contains(ignored_diagnostics, diagnostic.message) then
            table.insert(filtered_diagnostics, diagnostic)
          end
        end

        result.diagnostics = filtered_diagnostics
      end
    end

    original_diagnostics_handler(err, result, ctx, config)
  end

  vim.lsp.handlers["textDocument/publishDiagnostics"] = otter_diagnostics_filter
end

return M
