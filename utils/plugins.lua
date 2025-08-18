local M = {}

M.has = function(plugin)
  -- return vim.g.loaded_plugins[plugin] == 1
  local has, _ = pcall(require, plugin)
  return has
end

return M
