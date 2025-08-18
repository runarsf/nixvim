local M = {
  actions = {},
}

M.has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

M.has_words_after = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  local current_line = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
  if col >= #current_line then
    return false                                                 -- Cursor is at or beyond the end of the line
  else
    return current_line:sub(col + 1, col + 1):match("%S") ~= nil -- Checks if the next character is not a space
  end
end

M.colorize_text = function(context)
  return require("colorful-menu").blink_components_text(context)
end

M.colorize_highlights = function(context)
  return require("colorful-menu").blink_components_highlight(context)
end

M.use_kind_name = function(name)
  return function(context, items)
    for _, item in ipairs(items) do
      item.kind_name = name
    end

    return items
  end
end

-- Returns whether the completion list has a selected item or not
-- When `completion.list.selection.auto_insert` is true, this means the item is
-- replaced in the buffer.
M.actions.has_selected_item = function()
  return require('blink.cmp.completion.list').get_selected_item() ~= nil
end

-- Cancels the completion selection and leaves insert mode
-- Only hides if an item is selected
M.actions.cancel_and_leave_insert = function(cmp)
  if M.actions.has_selected_item() then
    local cancelled = cmp.cancel()

    if cancelled then
      -- NOTE: https://github.com/Saghen/blink.cmp/issues/1448#issuecomment-2730180188
      vim.schedule(function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
      end)
      return cancelled
    end
  end
end

-- Hides the completion menu and leaves insert mode
M.actions.hide_and_leave_insert = function(cmp)
  if cmp.is_visible() then
    local hidden = cmp.hide()

    if hidden then
      vim.cmd.stopinsert()
    end

    return hidden
  end
end

-- https://github.com/Saghen/blink.cmp/issues/547#issuecomment-2593493560
M.actions.cmdline_fallback = function(cmp)
  if not cmp.is_visible() then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-c>", true, true, true), "n", true)
    return true
  end
end

-- Selects the next item or indents
M.actions.select_next_or_indent = function(cmp)
  if M.has_words_before() then
    return cmp.select_next()
  else
    require('intellitab').indent()
    return true
  end
end

M.actions.select_next_and_wrap_if_in_list = function(cmp)
  if cmp.get_selected_item() ~= nil then
    local on_bottom = cmp.get_selected_item_idx() == #cmp.get_items()
    if on_bottom then
      return require('blink.cmp.completion.list').select(1, cmp)
    end
    return cmp.select_next()
  end
end

M.actions.select_prev_and_wrap_if_in_list = function(cmp)
  if cmp.get_selected_item() ~= nil then
    local on_top = cmp.get_selected_item_idx() == 1
    if on_top then
      return require('blink.cmp.completion.list').select(#cmp.get_items(), cmp)
    end
    return cmp.select_prev()
  end
end

return M
