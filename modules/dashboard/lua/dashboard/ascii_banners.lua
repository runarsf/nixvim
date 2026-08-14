-- https://oldcompcz.github.io/jgs/joan_stark/index-2.html
-- Some entries pad themselves out to max_width via string.rep, so this is a
-- function of the current window's max_width rather than a static table.
return function(max_width)
	local dog_width = max_width - 16
	local worm_width = math.floor((max_width - 15) / 6)

	return {
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
end
