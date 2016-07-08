local tTEST_TRAINER = {
	class = "Youngster",
	name = "Joey",
	pokemon = {
		{name = "rattata", level = 2, abilityList = {tackle, tail_whip}},
		{name = "pidgey", level = 2, abilityList = nil}
	},
	preBattle = {
		"I just lost, so I'm trying to find more POKEMON.",
		"Wait! You look weak! Come on, let's battle!"
	},
	postBattle = {
		"Ugh, I don't have any more pokemon"
	},
	location = Vector(-14240.000000, -14880.000000, 384.000000),
	reward = 64
}

local tBUG_CATCHER1 = {
	class = "bug_catcher",
	name = "Rick",
	pokemon = {
		{name = "weedle", level = 6, abilityList = nil},
		{name = "caterpie", level = 6, abilityList = nil}
	},
	preBattle = {
		"Hey! You have POKEMON! Come on!",
		"Let's battle 'em!"
	},
	postBattle = {
		"No! CATERPIE can't hack it!"
	},
	location = Vector(7036.093262, -12430.764648, 384.000000),
	reward = 72
}

local tBUG_CATCHER2 = {
	class = "bug_catcher",
	name = "Doug",
	pokemon = {
		{name = "weedle", level = 7, abilityList = nil},
		{name = "kaknua", level = 7, abilityList = nil},
		{name = "weedle", level = 7, abilityList = nil}
	},
	preBattle = {
		"Yo! You can't jam out if you're a POKEMON trainer!"
	},
	postBattle = {
		"Huh? I ran out of POKEMON!"
	},
	location = Vector(7034.688965, -10593.663086, 384.000000),
	reward = 84
}

local tBUG_CATCHER3 = {
	class = "bug_catcher",
	name = "Anthony",
	pokemon = {
		{name = "caterpie", level = 7, abilityList = nil},
		{name = "caterpie", level = 8, abilityList = nil}
	},
	preBattle = {
		"I might be little, but I won't like it if you go easy on me!"
	},
	postBattle = {
		"Oh boo. Nothing went right."
	},
	location = Vector(6803.724121, -8491.681641, 384.000000),
	reward = 96
}

local tBUG_CATCHER4 = {
	class = "bug_catcher",
	name = "Charlie",
	pokemon = {
		{name = "metapod", level = 7, abilityList = nil},
		{name = "caterpie", level = 7, abilityList = nil},
		{name = "metapod", level = 7, abilityList = nil}
	},
	preBattle = {
		"Did you know that POKEMON evolve?"
	},
	postBattle = {
		"Oh! I lost."
	},
	location = Vector(4883.586426, -6600.428711, 384.000000),
	reward = 84
}

local tBUG_CATCHER5 = {
	class = "bug_catcher",
	name = "Sammy",
	pokemon = {
		{name = "weedle", level = 9, abilityList = nil}
	},
	preBattle = {
		"Hey, wait up! What's the hurry? Why the rush?"
	},
	postBattle = {
		"I give! You're good at this!"
	},
	location = Vector(2975.224609, -7253.695313, 384.000000),
	reward = 108
}

local tLASS1 = {
	class = "Lass",
	name = "Janice",
	pokemon = {
		{name = "pidgey", level = 9, abilityList = nil},
		{name = "pidgey", level = 9, abilityList = nil}
	},
	preBattle = {
		"Excuse me! you looked at me, didn't you?"
	},
	postBattle = {
		"You're Mean!"
	},
	location = Vector(-9817.694336, 9829.219727, 384.000000),
	reward = 144
}

local tBUG_CATCHER6 = {
	class = "bug_catcher",
	name = "Colton",
	pokemon = {
		{name = "caterpie", level = 10, abilityList = nil},
		{name = "weedle", level = 9, abilityList = nil},
		{name = "caterpie", level = 10, abilityList = nil}
	},
	preBattle = {
		"Hey! I saw you in VIRIDIAN FOREST!"
	},
	postBattle = {
		"You beat me again!"
	},
	location = Vector(-7591.505859, 10743.260742, 384.000000),
	reward = 120
}

local tYOUNGSTER1 = {
	class = "Youngster",
	name = "Ben",
	pokemon = {
		{name = "caterpie", level = 10, abilityList = nil},
		{name = "weedle", level = 9, abilityList = nil},
		{name = "caterpie", level = 10, abilityList = nil}
	},
	preBattle = {
		"Hi! I like Shorts!",
		"They're delightfully comfy and easy to wear!"
	},
	postBattle = {
		"I don't believe it!"
	},
	location = Vector(-7050.179199, 11874.308594, 384.000000),
	reward = 176
}

local tBUG_CATCHER7 = {
	class = "bug_catcher",
	name = "Greg",
	pokemon = {
		{name = "weedle", level = 9, abilityList = nil},
		{name = "kakuna", level = 9, abilityList = nil},
		{name = "caterpie", level = 9, abilityList = nil},
		{name = "metapod", level = 9, abilityList = nil}
	},
	preBattle = {
		"Are you a TRAINER? Let's get with it right away!"
	},
	postBattle = {
		"If I had new POKEMON, I would've won!"
	},
	location = Vector(-4739.428711, 11765.757813, 384.000000),
	reward = 108
}

local tYOUNGSTER2 = {
	class = "Youngster",
	name = "Calvin",
	pokemon = {
		{name = "spearow", level = 14, abilityList = nil}
	},
	preBattle = {
		"Hey! You're not wearing shorts! What's wrong with you?"
	},
	postBattle = {
		"Lost! Lost! Lost!"
	},
	location = Vector(-4972.629395, 10335.331055, 384.000000),
	reward = 224
}

local tLASS2 = {
	class = "Lass",
	name = "Sally",
	pokemon = {
		{name = "rattata", level = 10, abilityList = nil},
		{name = "nidoran", level = 10, abilityList = nil}
	},
	preBattle = {
		"That look you gave me... It's so intriguing!"
	},
	postBattle = {
		"Be nice!"
	},
	location = Vector(-1749.048950, 10340.207031, 384.0000000),
	reward = 160
}

local tBUG_CATCHER8 = {
	class = "bug_catcher",
	name = "James",
	pokemon = {
		{name = "caterpie", level = 11, abilityList = nil},
		{name = "metapod", level = 11, abilityList = nil}
	},
	preBattle = {
		"I'll battle you with the pokemon I just caught."
	},
	postBattle = {
		"Done like dinner!"
	},
	location = Vector(-604.754700, 11928.620117, 384.000000),
	reward = 132
}

local tLASS3 = {
	class = "Lass",
	name = "Robin",
	pokemon = {
		{name = "jigglypuff", level = 14, abilityList = nil}
	},
	preBattle = {
		"Eek! Did you touch me?"
	},
	postBattle = {
		"That's it?"
	},
	location = Vector(1321.102417, 11738.562500, 384.000000),
	reward = 224
}

local tBUG_CATCHER9 = {
	class = "bug_catcher",
	name = "Kent",
	pokemon = {
		{name = "weedle", level = 11, abilityList = nil},
		{name = "kakuna", level = 11, abilityList = nil}
	},
	preBattle = {
		"placeholder"
	},
	postBattle = {
		"placeholder"
	},
	reward = 132
}

local tLASS4 = {
	class = "Lass",
	name = "Iris",
	pokemon = {
		{name = "clefairy", level = 14, abilityList = nil}
	},
	preBattle = {
		"placeholder"
	},
	postBattle = {
		"placeholder"
	},
	reward = 210
}

local tSUPER_NERD1 = {
	class = "super_nerd",
	name = "Jovan",
	pokemon = {
		{name = "magnemite", level = 11, abilityList = nil},
		{name = "voltorb", level = 11, abilityList = nil}
	},
	preBattle = {
		"placeholder"
	},
	postBattle = {
		"placeholder"
	},
	reward = 264
}

local tBUG_CATCHER10 = {
	class = "bug_catcher",
	name = "Robby",
	pokemon = {
		{name = "caterpie", level = 11, abilityList = nil},
		{name = "metapod", level = 11, abilityList = nil},
		{name = "caterpie", level = 11, abilityList = nil}
	},
	preBattle = {
		"placeholder"
	},
	postBattle = {
		"placeholder"
	},
	reward = 120
}

local tLASS5 = {
	class = "Lass",
	name = "Miriam",
	pokemon = {
		{name = "oddish", level = 11, abilityList = nil},
		{name = "bellsprout", level = 11, abilityList = nil}
	},
	preBattle = {
		"placeholder"
	},
	postBattle = {
		"placeholder"
	},
	reward = 173
}

local tYOUNGSTER3 = {
	class = "Youngster",
	name = "Josh",
	pokemon = {
		{name = "rattata", level = 10, abilityList = nil},
		{name = "rattata", level = 10, abilityList = nil},
		{name = "zubat", level = 10, abilityList = nil},
	},
	preBattle = {
		"placeholder"
	},
	postBattle = {
		"placeholder"
	},
	reward = 160
}

local tHIKER1 = {
	class = "Hiker",
	name = "Marcos",
	pokemon = {
		{name = "geodude", level = 10, abilityList = nil},
		{name = "geodude", level = 10, abilityList = nil},
		{name = "onix", level = 10, abilityList = nil},
	},
	preBattle = {
		"placeholder"
	},
	postBattle = {
		"placeholder"
	},
	reward = 360
}

local tROCKET_GRUNT1 = {
	class = "rocket_grunt",
	name = "",
	pokemon = {
		{name = "sandshrew", level = 11, abilityList = nil},
		{name = "rattata", level = 11, abilityList = nil},
		{name = "zubat", level = 11, abilityList = nil}
	},
	preBattle = {
		"placeholder"
	},
	postBattle = {
		"placeholder"
	},
	reward = 352
}

local tROCKET_GRUNT2 = {
	class = "rocket_grunt",
	name = "",
	pokemon = {
		{name = "zubat", level = 11, abilityList = nil},
		{name = "ekans", level = 11, abilityList = nil}
	},
	preBattle = {
		"placeholder"
	},
	postBattle = {
		"placeholder"
	},
	reward = 352
}

local tROCKET_GRUNT3 = {
	class = "rocket_grunt",
	name = "",
	pokemon = {
		{name = "rattata", level = 13, abilityList = nil},
		{name = "sandshrew", level = 13, abilityList = nil}
	},
	preBattle = {
		"placeholder"
	},
	postBattle = {
		"placeholder"
	},
	reward = 416
}

local tROCKET_GRUNT4 = {
	class = "rocket_grunt",
	name = "",
	pokemon = {
		{name = "rattata", level = 13, abilityList = nil},
		{name = "zubat", level = 13, abilityList = nil}
	},
	preBattle = {
		"placeholder"
	},
	postBattle = {
		"placeholder"
	},
	reward = 416
}

local tSUPER_NERD2 = {
	class = "rocket_grunt",
	name = "Miguel",
	pokemon = {
		{name = "grimer", level = 12, abilityList = nil},
		{name = "voltorb", level = 12, abilityList = nil},
		{name = "koffing", level = 12, abilityList = nil}
	},
	preBattle = {
		"placeholder"
	},
	postBattle = {
		"placeholder"
	},
	reward = 288
}

local tCAMPER1 = {
	class = "camper",
	name = "Liam",
	pokemon = {
		{name = "geodude", level = 10, abilityList = nil},
		{name = "sandshrew", level = 11, abilityList = nil}
	},
	preBattle = {
		"placeholder"
	},
	postBattle = {
		"placeholder"
	},
	reward = 288
}

local tBROCK = {
	class = "Brock",
	name = "",
	pokemon = {
		{name = "geodude", level = 10, abilityList = {tackle, defense_curl}},
		{name = "onix", level = 11, abilityList = {tackle,harden,rock_throw}}
	},
	preBattle = {
		"placeholder"
	},
	postBattle = {
		"placeholder"
	},
	reward = 288
}

--------------------------------------------------------------------------------
-- All trainer tables
--------------------------------------------------------------------------------
local tTRAINERS_ALL = {
	bug_catcher1 = tBUG_CATCHER1,
	bug_catcher2 = tBUG_CATCHER2,
	bug_catcher3 = tBUG_CATCHER3,
	bug_catcher4 = tBUG_CATCHER4,
	bug_catcher5 = tBUG_CATCHER5,
	bug_catcher6 = tBUG_CATCHER6,
	bug_catcher7 = tBUG_CATCHER7,
	bug_catcher8 = tBUG_CATCHER8,
	lass1 = tLASS1,
	lass2 = tLASS2,
	lass3 = tLASS3,
	youngster1 = tYOUNGSTER1,
	youngster2 = tYOUNGSTER2
}

local test = {
	youngster_joey = tTEST_TRAINER
}

--return test
return tTRAINERS_ALL
