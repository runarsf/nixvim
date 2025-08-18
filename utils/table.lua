local M = {}

M.drop = function(t, key)
  local val = t[key]
  t[key] = nil
  return val
end

-- https://stackoverflow.com/a/25709704
-- Will have issues with empty tables
M.is_list = function(t)
  local i = 0
  for _ in pairs(t) do
    i = i + 1
    if t[i] == nil then return false end
  end
  return true
end

M.length = function(t)
  local count = 0
  for _ in pairs(t) do count = count + 1 end
  return count
end

-- Convert a list to a set for easier lookup using set[key].
-- Does not preserve order or metatables.
-- Useful when you need to do a lot of O(1) lookups.
M.to_set = function(list)
  local set = {}
  for _, v in ipairs(list) do
    set[v] = true
  end
  return set
end

return M
