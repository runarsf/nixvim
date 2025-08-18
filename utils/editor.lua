local M = {}

M.is_wrapped = function()
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

return M
