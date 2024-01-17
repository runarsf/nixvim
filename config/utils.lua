local ok, luasnip = pcall(require, "luasnip")
if not ok then return end
local ok, cmp = pcall(require, "cmp")
if not ok then return end

ToggleMouse = function()
  vim.g.def_mouse = vim.g.def_mouse ~= nil and "vc" or vim.g.def_mouse
  if #vim.o.mouse > 0 then
    vim.g.def_mouse = vim.o.mouse
    vim.o.mouse = false
  else
    vim.o.mouse = vim.g.def_mouse
  end
end

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

  -- vim.wo always returns a number, but expects a bool when assigning
  local int_to_bool = function(int)
    if int == 0 then return false end
    if int == 1 then return true end
    return int
  end

  local has_blankline, _ = pcall(require, "indent_blankline")

  if w.number or w.relativenumber then
    g.def_number         = int_to_bool(w.number)
    g.def_relativenumber = int_to_bool(w.relativenumber)
    g.def_wrap           = int_to_bool(w.wrap)
    g.def_list           = int_to_bool(w.list)
    g.def_signcolumn     = w.signcolumn
    g.def_mouse          = o.mouse

    -- Disable
    if has_blankline then vim.cmd[[IndentBlanklineDisable]] end
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
    w.number         = g.def_number
    w.relativenumber = g.def_relativenumber
    w.wrap           = g.def_wrap
    w.list           = g.def_list
    w.signcolumn     = g.def_signcolumn
    o.mouse          = g.def_mouse
    -- vim.cmd("loadview 3")
  end
end

Glow = function()
  local ok, toggleterm = pcall(require, "toggleterm.terminal")
  if not ok then return end
  local Terminal = toggleterm.Terminal
  local file = vim.fn.expand("%:p") -- current file
  if file:sub(-#'.md') ~= '.md' then
    file = vim.fn.expand("%:p:h") -- current directory
  end
  local glow = Terminal:new({ cmd="PAGER='less -r' glow -s dark -p "..file, hidden=false })
  glow:toggle()
end

HasWordsBefore = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
