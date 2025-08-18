local M = {}

M.get_random_quote = function()
	local quotes = require("utils.quotes")
	print(quotes)
	local selected = quotes[math.random(#quotes)]
	local quote = type(selected) == "table" and selected[1] or selected
	---@diagnostic disable-next-line: undefined-field
	local author = type(selected) == "table" and selected[2] or nil

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

M.run_command = function(command)
	local handle = assert(io.popen(command, "r"))
	local output = assert(handle:read("*a"))

	handle:close()

	return output:gsub("^(\n+)", ""):gsub("(\n+)$", "")
end

M.remove_ansi_codes = function(str)
	return M.run_command("printf '" .. str .. "' | ansi2txt")
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
	-- local height = vim.api.nvim_win_get_height(0)

	local max_width = width - 2 * 3
	local dog_width = max_width - 16
	local worm_width = math.floor((max_width - 15) / 6)

	-- https://oldcompcz.github.io/jgs/joan_stark/index-2.html
	local ascii_banners = {
		{ -- Fox
			[[              /^._ ]],
			[[,___,--~~~~--' /'~']],
			[[`~--~\ )___,)/'    ]],
			[[    (/\\_  (/\\_   ]],
		},
		{ -- Fox
			[[ /\           ]],
			[[(~(           ]],
			[[ ) )     |\_/|]],
			[[( _-----_(.".)]],
			[[  (       \o/ ]],
			[[  /|/--\|\    ]],
			[[ " "   " "    ]],
		},
		{ -- Hedgehog
			[[   .|||||||||.  ]],
			[[  ||||||||||||| ]],
			[[ /. `|||||||||||]],
			[[o__,_||||||||||']],
		},
		{ -- Cat
			[[ ／|_      ]],
			[[(o o /     ]],
			[[ |.   ~.   ]],
			[[ じしf_,)ノ]],
		},
		{ -- pb
			[[                __     ]],
			[[               /\/'-,  ]],
			[[       ,--'''''   /"   ]],
			[[ ____,'.  )       \___ ]],
			[['"""""------'"""`-----']],
		},
		{
			[[          __   ]],
			[[ \ ______/ V`-,]],
			[[  }        /~~ ]],
			[[ /_)^ --,r'    ]],
			[[|b      |b     ]],
		},
		{ -- Duck
			[[   _  ]],
			[[,_(')<]],
			[[\___) ]],
		},
		{ -- Whale
			[[      ::.     ]],
			[[(\./)  .-""-. ]],
			[[ `\'-'`      \]],
			[[   '.___,_^__/]],
		},
		{ -- Dog
			[[     __  ]],
			[[(___()'`;]],
			[[/,    /` ]],
			[[\\"--\\  ]],
		},
		{ -- Sitting dog
			[[    __  ]],
			[[   ()'`;]],
			[[   /\|` ]],
			[[  /  |  ]],
			[[(/_)_|_ ]],
		},
		{ -- Sleeping dog
			[[       z              ]],
			[[    Z                 ]],
			[[      z               ]],
			[[  ."-.                ]],
			[[ /|  | _o.----.    _  ]],
			[[/\_  \/ /  __  \_// ) ]],
			[[\__)-/_/\_____)____/  ]],
		},
		{ -- Worm
			[[      ]] .. string.rep([[      ]], worm_width) .. [[      __ ]],
			[[(\   .]] .. string.rep([[-.   .]], worm_width) .. [[-.   /_")]],
			[[ \\_//]] .. string.rep([[^\\_//]], worm_width) .. [[^\\_//   ]],
			[[  `"´ ]] .. string.rep([[  `"´ ]], worm_width) .. [[  `"´    ]],
		},
		{ -- Dachshund
			[[      ]] .. string.rep(" ", dog_width) .. [[    .-.   ]],
			[[(_____]] .. string.rep("_", dog_width) .. [[___()6 `-,]],
			[[(   __]] .. string.rep("_", dog_width) .. [[_   /''"` ]],
			[[//\\  ]] .. string.rep(" ", dog_width) .. [[ //\\     ]],
			[["" "" ]] .. string.rep(" ", dog_width) .. [[ "" ""    ]],
		},
		{ -- Dog
			[[ ..^____/]],
			[[`-. ___ )]],
			[[  ||  || ]],
		},
		{ -- Minecraft fox
			[[⬜⬜        ⬜⬜]],
			[[⬜⬛        ⬛⬜]],
			[[🟧🟧🟧🟧🟧🟧🟧🟧]],
			[[🟧🟧🟧🟧🟧🟧🟧🟧]],
			[[🟧🟧🟧🟧🟧🟧🟧🟧]],
			[[⬛⬜🟧🟧🟧🟧⬜⬛]],
			[[🟧🟧⬜⬛⬛⬜🟧🟧]],
			[[⬜⬜⬜⬜⬜⬜⬜⬜]],
		},
		{ -- Amoebas
			{ [[_____.______ <-- amoeba]] },
			{ [[_____.______ <-- upside down amoeba]] },
			{ [[_____!______ <-- amoeba with a chef's hat]] },
			{ [[_____.|_____ <-- amoeba trying to climb a fence]] },
			{ [[___......___ <-- queue of amoebas]] },
			{ [[_____*______ <-- amoeba with flower costume]] },
			{ [[_____.z_____ <-- sleeping amoeba]] },
			{ [[____o.o_____ <-- amoeba with glasses]] },
			{ [[_____.>_____ <-- amoeba with a boomerang]] },
			{ [[_____$._____ <-- opulent amoeba]] },
			{ [[_____.._____ <-- amoebas conversing]] },
			{ [[_____.}_____ <-- amoeba with a bow and arrow]] },
			{ [[_____o=o____ <-- amoeba skateboarding]] },
		},
	}

	return table.concat(M.get_ascii(ascii_banners), "\n")
end

-- FIXME: Sometimes the pokemon only partially renders.
--        Pokemon rendering is disabled in get_banner_section for now.
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
		text = banner,
		align = "center",
		padding = 2,
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

M.render_terminal_banner = function(banner)
	local utf8 = require("lua-utf8")

	local lines = vim.split(banner, "\n")
	local height = #lines
	local width = 0

	for _, line in ipairs(lines) do
		local clean_line = M.remove_ansi_codes(line)
		local line_length = utf8.len(clean_line)
		if line_length > width then
			width = line_length or 0
		end
	end

	local primary = M.find_primary_color(banner)
	local r, g, b = primary.r, primary.g, primary.b
	local hex = string.format("#%02x%02x%02x", r, g, b)

	vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = hex })

	-- FIXME: https://github.com/folke/snacks.nvim/issues/1642
	-- local renderer = "printf '" .. pokemon .. "'"
	local renderer = table.concat({
		"while IFS= read -r line; do",
		"  pad_width=$(( ($(tput cols) - " .. width .. " ) / 2 ));",
		"  indent=$(printf '%*s' $pad_width \"\");",
		'  printf \'%s%s\\n\' "$indent" "$line";',
		"done <<'EOF'",
		banner,
		"EOF",
	}, "\n")

	return {
		section = "terminal",
		cmd = renderer,
		height = height,
		padding = 2,

		-- FIXME: https://github.com/folke/snacks.nvim/issues/1642
		-- width = width,
		-- align = "center",
	}
end

M.get_banner_section = function()
	-- math.randomseed(os.time())

	-- if math.random() < 0.5 then
	-- 	return render_terminal_banner(get_random_pokemon(0.01))
	-- else
	return M.render_text_banner(M.get_random_ascii_art())
	-- end
end

return M
