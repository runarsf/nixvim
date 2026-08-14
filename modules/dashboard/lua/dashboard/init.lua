local M = {}

M.pick_random_quote = function()
	local quotes = require("dashboard.quotes")
	local selected = quotes[math.random(#quotes)]
	local quote = type(selected) == "table" and selected[1] or selected
	---@diagnostic disable-next-line: undefined-field
	local author = type(selected) == "table" and selected[2] or nil
	return quote, author
end

M.format_quote_with_author = function(quote, author)
	if not author then
		return quote
	end

	-- Calculate padding for right-aligned author
	local quote_lines = vim.split(quote, "\n")
	local max_width = 0

	-- Find the width of the longest line in the quote
	for _, line in ipairs(quote_lines) do
		local line_width = vim.fn.strdisplaywidth(line)
		if line_width > max_width then
			max_width = line_width
		end
	end

	-- Format author line with padding to align with the longest quote line
	local author_line = "— " .. author
	local author_width = vim.fn.strdisplaywidth(author_line)
	local padding_needed = math.max(0, max_width - author_width)
	local padded_author = string.rep(" ", padding_needed) .. author_line

	return quote .. "\n" .. padded_author
end

M.get_random_quote = function()
	local quote, author = M.pick_random_quote()
	return M.format_quote_with_author(quote, author)
end

-- Builds the whole alpha layout element (not just `val`) so the author line
-- can be excluded from the "Comment" highlight applied to the quote lines.
-- alpha's layout_element.text only supports per-line highlighting via a
-- table shaped like { {hl_group, col_start, col_end}, ... } per line, and
-- there's no way to know which line is the author from inside alpha itself
-- (see lua/alpha.lua's layout_element.text/alpha.highlight), so the full
-- element has to be assembled here instead of just returning quote text.
M.get_quote_element = function()
	local quote, author = M.pick_random_quote()
	local lines = vim.split(M.format_quote_with_author(quote, author), "\n")

	local hl = {}
	for i = 1, #lines do
		hl[i] = { { "Comment", 0, -1 } }
	end
	if author then
		hl[#lines] = {} -- author line: leave at the default text color
	end

	return {
		type = "text",
		val = lines,
		opts = {
			position = "center",
			hl = hl,
		},
	}
end

M.run_command = function(command)
	local handle = assert(io.popen(command, "r"))
	local output = assert(handle:read("*a"))

	handle:close()

	return output:gsub("^(\n+)", ""):gsub("(\n+)$", "")
end

M.get_ascii = function(xs)
	math.randomseed(os.time())
	local ascii = xs[math.random(#xs)]
	if type(ascii[1]) == "table" then
		return M.get_ascii(ascii)
	end
	return ascii
end

M.get_random_ascii_art = function()
	local width = vim.api.nvim_win_get_width(0)
	local max_width = width - 2 * 3

	local ascii_banners = require("dashboard.ascii_banners")(max_width)

	return table.concat(M.get_ascii(ascii_banners), "\n")
end

M.get_random_pokemon = function(shiny_rate)
	math.randomseed(os.time())
	local generate_shiny = math.random() < (shiny_rate or -1) --> use krabby's default if unset
	local pokemon_command = "krabby random --no-title"

	if generate_shiny then
		pokemon_command = pokemon_command .. " --shiny"
	end

	return M.run_command(pokemon_command)
end

M.render_text_banner = function(banner)
	return {
		type = "text",
		-- must be a table of lines, not a raw multi-line string: alpha's
		-- layout_element.text only highlights every line (and advances
		-- state.line by the full height) when val is already a table (see
		-- get_quote_element for the same issue in more detail)
		val = vim.split(banner, "\n"),
		opts = {
			position = "center",
			hl = "Statement",
		},
	}
end

M.rgb_to_hsv = function(r, g, b)
	r, g, b = r / 255, g / 255, b / 255
	local max, min = math.max(r, g, b), math.min(r, g, b)
	local delta = max - min
	local h, s, v = 0, 0, max

	if delta > 0 then
		s = delta / max
		if max == r then
			h = (g - b) / delta
		elseif max == g then
			h = 2 + (b - r) / delta
		else
			h = 4 + (r - g) / delta
		end
		h = (h * 60) % 360
	end

	return {
		h = h / 360,
		s = s,
		v = v,
	}
end

M.find_primary_color = function(str)
	local color_frequencies = {}

	for code in str:gmatch("\27%[(.-)m") do
		local parts = {}

		for part in code:gmatch("[^;]+") do
			parts[#parts + 1] = part
		end

		if #parts >= 5 and (parts[1] == "38" or parts[1] == "48") and parts[2] == "2" then
			local r = tonumber(parts[3])
			local g = tonumber(parts[4])
			local b = tonumber(parts[5])

			if r and g and b then
				local rgb_str = string.format("%d,%d,%d", r, g, b)
				color_frequencies[rgb_str] = (color_frequencies[rgb_str] or 0) + 1
			end
		end
	end

	local best_color = {
		value = { r = 255, g = 255, b = 255 },
		normalized_frequency = 0,
		luminance = 0,
		saturation = 0,
		score = -1,
	}

	local total_pixels = 0
	for _, frequency in pairs(color_frequencies) do
		total_pixels = total_pixels + frequency
	end

	for rgb_str, frequency in pairs(color_frequencies) do
		local r, g, b = rgb_str:match("(%d+),(%d+),(%d+)")
		r, g, b = tonumber(r), tonumber(g), tonumber(b)

		if r and g and b then
			local luminance = (0.2126 * r + 0.7152 * g + 0.0722 * b) / 255 -- https://www.w3.org/WAI/GL/wiki/Relative_luminance

			if luminance > 0.333 then
				local normalized_frequency = frequency / total_pixels
				local hsv = M.rgb_to_hsv(r, g, b)
				local saturation = hsv.s

				local frequency_weight = 0.75
				local luminance_weight = 0.05
				local saturation_weight = 0.2

				local score = frequency_weight * normalized_frequency
					+ saturation_weight * saturation
					- luminance_weight * luminance

				if score > best_color.score then
					best_color = {
						value = { r = r, g = g, b = b },
						normalized_frequency = normalized_frequency,
						luminance = luminance,
						saturation = saturation,
						score = score,
					}
				end
			end
		end
	end

	return best_color.value
end

-- Highlight groups for 24-bit ANSI fg/bg color pairs are created lazily and
-- cached by hex pair, since the same colors tend to recur across a
-- pokemon's frame. krabby renders each "pixel" as a half-block character
-- with its own independent foreground *and* background color, so both need
-- to be tracked together rather than assuming only fg matters.
local ansi_hl_cache = {}
M.get_ansi_hl_group = function(fg_hex, bg_hex)
	local key = (fg_hex or "") .. "|" .. (bg_hex or "")
	local group = ansi_hl_cache[key]
	if not group then
		group = "AlphaAnsi_" .. key:gsub("[#|]", "_")
		vim.api.nvim_set_hl(0, group, { fg = fg_hex, bg = bg_hex })
		ansi_hl_cache[key] = group
	end
	return group
end

-- Strips SGR escape codes from one line of ANSI-colored text, returning the
-- plain text plus a list of { hl_group, col_start, col_end } spans (byte
-- offsets, matching what nvim_buf_add_highlight/alpha.highlight expect) for
-- the colored runs. Only 24-bit truecolor codes (38/48;2;r;g;b) are
-- handled; a bare/`0` code resets both fg and bg.
M.parse_ansi_line = function(line)
	local clean_parts = {}
	local spans = {}
	local col = 0
	local current_fg, current_bg = nil, nil
	local current_hl = nil
	local span_start = 0
	local pos = 1
	local len = #line

	while pos <= len do
		local esc_start, esc_end, code = line:find("\27%[([%d;]*)m", pos)
		local text = esc_start and line:sub(pos, esc_start - 1) or line:sub(pos)

		if #text > 0 then
			clean_parts[#clean_parts + 1] = text
			col = col + #text
		end

		if not esc_start then
			break
		end

		if current_hl and col > span_start then
			spans[#spans + 1] = { current_hl, span_start, col }
		end
		span_start = col

		local parts = {}
		for part in code:gmatch("[^;]+") do
			parts[#parts + 1] = part
		end

		if code == "" or parts[1] == "0" then
			current_fg, current_bg = nil, nil
		elseif parts[1] == "38" and parts[2] == "2" and parts[3] and parts[4] and parts[5] then
			current_fg = string.format("#%02x%02x%02x", tonumber(parts[3]), tonumber(parts[4]), tonumber(parts[5]))
		elseif parts[1] == "48" and parts[2] == "2" and parts[3] and parts[4] and parts[5] then
			current_bg = string.format("#%02x%02x%02x", tonumber(parts[3]), tonumber(parts[4]), tonumber(parts[5]))
		elseif parts[1] == "39" then
			current_fg = nil
		elseif parts[1] == "49" then
			current_bg = nil
		end

		current_hl = (current_fg or current_bg) and M.get_ansi_hl_group(current_fg, current_bg) or nil

		pos = esc_end + 1
	end

	if current_hl and col > span_start then
		spans[#spans + 1] = { current_hl, span_start, col }
	end

	return table.concat(clean_parts), spans
end

M.render_pokemon_banner = function(banner)
	local raw_lines = vim.split(banner, "\n")
	local clean_lines = {}
	local hl = {}

	for i, line in ipairs(raw_lines) do
		clean_lines[i], hl[i] = M.parse_ansi_line(line)
	end

	-- alpha.highlight tells "one span-list per line" apart from "a flat
	-- span-list for a single line" by checking whether hl[1][1] is itself a
	-- table (see lua/alpha.lua's alpha.highlight). If the pokemon's first
	-- line happens to have no colored spans (common — krabby's art often
	-- starts with a blank/padding line), hl[1] is `{}` and that heuristic
	-- misreads the whole per-line table as single-line spans, silently
	-- dropping every highlight. A zero-width dummy span keeps hl[1] visibly
	-- a "list of tables" without highlighting anything.
	if #hl > 0 and #hl[1] == 0 then
		hl[1] = { { "Normal", 0, 0 } }
	end

	local primary = M.find_primary_color(banner)
	local hex = string.format("#%02x%02x%02x", primary.r, primary.g, primary.b)

	-- Accents the buttons/quote below to match the pokemon's dominant
	-- color. AlphaBannerAccent falls back to linking Keyword (set below)
	-- whenever the text-banner branch is picked instead.
	vim.api.nvim_set_hl(0, "AlphaBannerAccent", { fg = hex })

	return {
		type = "text",
		val = clean_lines,
		opts = {
			position = "center",
			hl = hl,
		},
	}
end

M.get_banner_section = function()
	if math.random() < 0.5 then
		return M.render_pokemon_banner(M.get_random_pokemon(0.01))
	else
		return M.render_text_banner(M.get_random_ascii_art())
	end
end

-- default = true means this only takes effect if nothing (i.e. the pokemon
-- branch in get_banner_section) has already set an explicit color
vim.api.nvim_set_hl(0, "AlphaBannerAccent", { link = "Keyword", default = true })

return M
