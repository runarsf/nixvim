local ok, luasnip = pcall(require, "luasnip")
if not ok then return end
local ok, cmp = pcall(require, "cmp")
if not ok then return end

CopyMode = function()
  local g = vim.g
  local o = vim.o
  local w = vim.wo
  vim.cmd("stopinsert")
  g.def_number         = g.def_number ~= nil and true or g.def_number
  g.def_relativenumber = g.def_relativenumber ~= nil and true or g.def_relativenumber
  g.def_wrap           = g.def_wrap ~= nil and false or g.def_wrap
  g.def_list           = g.def_list ~= nil and true or g.def_list
  g.def_signcolumn     = g.def_signcolumn ~= nil and "yes" or g.def_signcolumn
  g.def_mouse          = g.def_mouse ~= nil and "vc" or g.def_mouse
  g.def_virtcolumn     = g.def_virtcolumn ~= nil and true or g.def_virtcolumn

  -- vim.wo always returns a number, but expects a bool when assigning
  local int_to_bool = function(int)
    if int == 0 then return false end
    if int == 1 then return true end
    return int
  end

  local has_blankline, _ = pcall(require, "indent_blankline")
  local has_virtcol, virtcolumn = pcall(require, "virt-column")

  if w.number or w.relativenumber then
    g.def_number         = int_to_bool(w.number)
    g.def_relativenumber = int_to_bool(w.relativenumber)
    g.def_wrap           = int_to_bool(w.wrap)
    g.def_list           = int_to_bool(w.list)
    g.def_signcolumn     = w.signcolumn
    g.def_mouse          = o.mouse

    -- Disable
    if has_blankline then vim.cmd[[IndentBlanklineDisable]] end
    if has_virtcol then virtcolumn.update { enabled = false } end
    w.number         = false
    w.relativenumber = false
    w.wrap           = false
    w.list           = false
    w.signcolumn     = "no"
    o.mouse          = false
    -- vim.cmd("mkview 3")
    -- vim.api.nvim_input("zRzz")
  else
    -- Restore previous state
    if has_blankline then vim.cmd[[IndentBlanklineEnable]] end
    if has_virtcol then virtcolumn.update { enabled = true } end
    w.number         = g.def_number
    w.relativenumber = g.def_relativenumber
    w.wrap           = g.def_wrap
    w.list           = g.def_list
    w.signcolumn     = g.def_signcolumn
    o.mouse          = g.def_mouse
    -- vim.cmd("loadview 3")
  end
end

HasWordsBefore = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

HasWordsAfter = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  local current_line = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
  if col >= #current_line then
    return false -- Cursor is at or beyond the end of the line
  else
    return current_line:sub(col + 1, col + 1):match("%S") ~= nil -- Checks if the next character is not a space
  end
end

IsWrapped = function()
  -- Check if the current line is wrapped

  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(win)
  local line_num = cursor[1]

  -- Get screen row of the start of the line
  local row_start = vim.fn.screenpos(win, line_num, 0).row

  -- Get screen row of the end of the line by moving to the end of the line and checking the row
  local line_content = vim.api.nvim_buf_get_lines(buf, line_num - 1, line_num, false)[1]
  local row_end = vim.fn.screenpos(win, line_num, #line_content + 1).row

  -- A line is wrapped if the start and end positions are on different rows
  return row_start ~= row_end
end

