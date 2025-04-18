function alpha_layout()
	-- Only runs this script if Alpha Screen loads -- only if there isn't files to read
	if vim.api.nvim_exec("echo argc()", true) ~= "0" then
		return {}
	end

	-- Statement, Exception
	--- Create button for initial keybind.
	--- @param sc string
	--- @param txt string
	--- @param hl string
	--- @param keybind string optional
	--- @param keybind_opts table optional
	local function button(sc, txt, keybind)
		local sc_ = sc:gsub("%s", ""):gsub("SPC", "<Leader>")

		local opts = {
			position = "center",
			shortcut = sc,
			cursor = 3,
			width = 40,
			align_shortcut = "right",
			hl_shortcut = "Type",
		}

		if keybind then
			keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
			opts.keymap = { "n", sc_, keybind, keybind_opts }
		end

		local function on_press()
			local key = vim.api.nvim_replace_termcodes(sc_ .. "<Ignore>", true, false, true)
			vim.api.nvim_feedkeys(key, "normal", false)
		end

		return {
			type = "button",
			val = txt,
			on_press = on_press,
			opts = opts,
		}
	end

	-- Function to retrieve console output.
	local function capture(cmd)
		local handle = assert(io.popen(cmd, "r"))
		local output = assert(handle:read("*a"))
		handle:close()
		return output
	end

	-- To split our quote, artist and source.
	-- And automatically center it for screen loader of the header.
	local function split(s)
		local t = {}
		local max_line_length = vim.api.nvim_get_option("columns")
		local longest = 0 -- Value of longest string is 0 by default
		for far in s:gmatch("[^\r\n]+") do
			-- Break the line if it's actually bigger than terminal columns
			local line
			far:gsub("(%s*)(%S+)", function(spc, word)
				if not line or #line + #spc + #word > max_line_length then
					table.insert(t, line)
					line = word
				else
					line = line .. spc .. word
					longest = max_line_length
				end
			end)
			-- Get the string that is the longest
			if #line > longest then
				longest = #line
			end
			table.insert(t, line)
		end
		-- Center all strings by the longest
		for i = 1, #t do
			local space = longest - #t[i]
			local left = math.floor(space / 2)
			local right = space - left
			t[i] = string.rep(" ", left) .. t[i] .. string.rep(" ", right)
		end
		return t
	end

	local padding = 2
	local below_buttons = 1
	math.randomseed(os.time())

	local footer = {
		type = "text",
		-- val = split(capture('fortune --short | tail -n +2')),
		val = split(quotes[math.random(#quotes)]),
		opts = {
			position = "center",
			hl = "Comment",
		},
	}
	local footer_lines = #footer.val

	local buttons = {
		type = "group",
		val = {
			button("i", "󰈔  New Buffer", "<CMD>enew | startinsert<CR>"),
			button(
				"f",
				"󰱼  Find files",
				"<CMD>lua require('search').open({ tab_name = 'Files', tele_opts = telescope_options, })<CR>"
			),
			button("n", "󰙅  File tree", "<CMD>lua MiniFiles.open()<CR>"),
			button("r", "󱋡  Recent files", "<CMD>Telescope oldfiles<CR>"),
			button("q", "󰅚  Quit", "<CMD>qall<CR>"),
			-- button("l", "  Projects", ':Telescope marks<CR>'),
		},
		opts = {
			spacing = 1,
		},
	}
	local buttons_lines = #buttons.val * (1 + buttons.opts.spacing) - 1

	local width = vim.api.nvim_win_get_width(0)
	local height = vim.api.nvim_win_get_height(0)

	local dogw = width - (16 + 2 * 3)
	local wormw = math.floor((width - (15 + 2 * 3)) / 6)
	-- FIXME giraffe height is off with one line
	local giraffeh = height - (7 + buttons_lines + footer_lines + padding + 2 * 2 + 2 + below_buttons)
	local giraffe = {
		[[.-",    ]],
		[[`~||    ]],
	}
	for _ = 1, giraffeh do
		table.insert(giraffe, [[  ||    ]])
	end
	table.insert(giraffe, [[  ||___ ]])
	table.insert(giraffe, [[  (':.)`]])
	table.insert(giraffe, [[  || || ]])
	table.insert(giraffe, [[  || || ]])
	table.insert(giraffe, [[  ^^ ^^ ]])

	-- https://oldcompcz.github.io/jgs/joan_stark/index-2.html
	local headers = {
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
			[[ ／|_     ]],
			[[(o o /    ]],
			[[ |.   ~.  ]],
			[[ じしf_,)ノ]],
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
			[[      ]] .. string.rep([[      ]], wormw) .. [[      __ ]],
			[[(\   .]] .. string.rep([[-.   .]], wormw) .. [[-.   /_")]],
			[[ \\_//]] .. string.rep([[^\\_//]], wormw) .. [[^\\_//   ]],
			[[  `"´ ]] .. string.rep([[  `"´ ]], wormw) .. [[  `"´    ]],
		},
		{ -- Dachshund
			[[      ]] .. string.rep(" ", dogw) .. [[    .-.   ]],
			[[(_____]] .. string.rep("_", dogw) .. [[___()6 `-,]],
			[[(   __]] .. string.rep("_", dogw) .. [[_   /''"` ]],
			[[//\\  ]] .. string.rep(" ", dogw) .. [[ //\\     ]],
			[["" "" ]] .. string.rep(" ", dogw) .. [[ "" ""    ]],
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
		giraffe,
		{ -- Amoebas
			{ [[_____.______ <-- amoeba]] },
			{ [[_____.______ <-- upside down amoeba]] },
			{ [[_____!______ <-- amoeba with a chef's hat]] },
			{ [[_____.|_____ <-- amoeba trying to climb a fence]] },
			{ [[___.......__ <-- queue of amoebas]] },
			{ [[_____*______ <-- amoeba with flower costume]] },
			{ [[_____.z_____ <-- sleeping amoeba]] },
			{ [[____________ <-- invisible amoeba]] },
			{ [[_____o______ <-- bodybuilding amoeba]] },
			{ [[_____O______ <-- bodybuilding amoeba on steroids]] },
			{ [[____o.o_____ <-- amoeba with glasses]] },
			{ [[____.-._____ <-- two amoebas carrying a log]] },
			{ [[_____.>_____ <-- amoeba with a boomerang]] },
			{ [[_____.-_____ <-- amoeba with a rifle]] },
			{ [[_____$._____ <-- opulent amoeba]] },
			{ [[_____.._____ <-- amoebas conversing]] },
			{ [[_____.}_____ <-- amoeba with a bow and arrow]] },
			{ [[_____o=o____ <-- amoeba skateboarding]] },
			{
				[[ ::::::::::                        ]],
				[[ ::::::::::                        ]],
				[[_::::::::::_ <-- amoebas protesting]],
			},
		},
	}

	GetAscii = function(xs)
		local ascii = xs[math.random(#xs)]
		if type(ascii[1]) == "table" then
			return GetAscii(ascii)
		end
		return ascii
	end

	local header = {
		type = "text",
		val = GetAscii(headers),
		opts = {
			position = "center",
			hl = "Statement",
		},
	}
	local header_lines = #header.val

	local lines_remaining = height - (buttons_lines + footer_lines + header_lines + padding)

	if lines_remaining < 0 then
		return {}
	end

	local top_padding = math.floor(lines_remaining / 2)
	local bottom_padding = lines_remaining - top_padding

	return {
		{ type = "padding", val = top_padding },
		header,
		{ type = "padding", val = padding },
		buttons,
		{ type = "padding", val = below_buttons }, -- -1 for the padding between buttons and footer
		footer,
		{ type = "padding", val = bottom_padding },
	}
end
