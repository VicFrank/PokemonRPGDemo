local tTEST_TRAINER = {
	class = "Youngster",
	name = "Joey",
	pokemon = {
		{name = "rattata", level = 2, abilityList = {"tackle", "tail_whip"}},
		{name = "pidgey", level = 2, abilityList = nil}
	},
	preBattle = {
		"I just lost, so I'm trying to find more POKEMON.",
		"Wait! You look weak! Come on, let's battle!"
	},
	postBattle = {
		"Ugh, I don't have any more pokemon"
	},
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
	reward = 72
}

local tBUG_CATCHER2 = {
	class = "bug_catcher",
	name = "Doug",
	pokemon = {
		{name = "weedle", level = 7, abilityList = nil},
		{name = "kakuna", level = 7, abilityList = {"tackle","harden"}},
		{name = "weedle", level = 7, abilityList = nil}
	},
	preBattle = {
		"Yo! You can't jam out if you're a POKEMON trainer!"
	},
	postBattle = {
		"Huh? I ran out of POKEMON!"
	},
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
	reward = 96
}

local tBUG_CATCHER4 = {
	class = "bug_catcher",
	name = "Charlie",
	pokemon = {
		{name = "metapod", level = 7, abilityList = {"tackle","harden"}},
		{name = "caterpie", level = 7, abilityList = nil},
		{name = "metapod", level = 7, abilityList = {"tackle","harden"}}
	},
	preBattle = {
		"Did you know that POKEMON evolve?"
	},
	postBattle = {
		"Oh! I lost."
	},
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
	reward = 176
}

local tBUG_CATCHER7 = {
	class = "bug_catcher",
	name = "Greg",
	pokemon = {
		{name = "weedle", level = 9, abilityList = nil},
		{name = "kakuna", level = 9, abilityList = {"tackle","harden"}},
		{name = "caterpie", level = 9, abilityList = nil},
		{name = "metapod", level = 9, abilityList = {"tackle","harden"}}
	},
	preBattle = {
		"Are you a TRAINER? Let's get with it right away!"
	},
	postBattle = {
		"If I had new POKEMON, I would've won!"
	},
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
	reward = 224
}

local tLASS2 = {
	class = "Lass",
	name = "Sally",
	pokemon = {
		{name = "rattata", level = 10, abilityList = nil},
		{name = "nidoran_m", level = 10, abilityList = nil}
	},
	preBattle = {
		"That look you gave me... It's so intriguing!"
	},
	postBattle = {
		"Be nice!"
	},
	reward = 160
}

local tBUG_CATCHER8 = {
	class = "bug_catcher",
	name = "James",
	pokemon = {
		{name = "caterpie", level = 11, abilityList = nil},
		{name = "metapod", level = 11, abilityList = {"tackle","harden"}}
	},
	preBattle = {
		"I'll battle you with the pokemon I just caught."
	},
	postBattle = {
		"Done like dinner!"
	},

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

	reward = 224
}

local tBUG_CATCHER9 = {
	class = "bug_catcher",
	name = "Kent",
	pokemon = {
		{name = "weedle", level = 11, abilityList = nil},
		{name = "kakuna", level = 11, abilityList = {"tackle","harden"}}
	},
	preBattle = {
		"Suspicious men are in the cave. What about you?"
	},
	postBattle = {
		"You got me!"
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
		"What?",
		"I'm waiting for my friends to find me here."
	},
	postBattle = {
		"I lost?"
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
		"What! Don't sneak up on me!"
	},
	postBattle = {
		"My POKEMON won't do!"
	},
	reward = 264
}

local tBUG_CATCHER10 = {
	class = "bug_catcher",
	name = "Robby",
	pokemon = {
		{name = "caterpie", level = 11, abilityList = nil},
		{name = "metapod", level = 11, abilityList = {"tackle","harden"}},
		{name = "caterpie", level = 11, abilityList = nil}
	},
	preBattle = {
		"You need to go through this cave to get to CERULEAN CITY."
	},
	postBattle = {
		"I lost."
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
		"Wow! It's way bigger in here than I thought!"
	},
	postBattle = {
		"Oh! I lost it!"
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
		"Did you come to explore the cave, too?"
	},
	postBattle = {
		"Losing stinks! It's so uncool."
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
		"Whoa! You shocked me!",
		"Oh, you're just a kid!"
	},
	postBattle = {
		"WoW! Shocked again!"
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
		"We, TEAM ROCKET, are POKEMON gangsters!",
		"We strike fear with our strength!"
	},
	postBattle = {
		"I blew it!"
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
		"We're pulling a big job here!",
		"Get lost, kid!"
	},
	postBattle = {
		"So, you are good..."
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
		"Little kids shouldn't be messing around with grown ups!",
		"It could be bad news!"
	},
	postBattle = {
		"I'm steamed!"
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
		"We, TEAM ROCKET, shall find the fossils!",
		"Reviving POKEMON from them will earn us huge riches!"
	},
	postBattle = {
		"Urgh! Now I'm mad!"
	},
	reward = 416
}

local tSUPER_NERD2 = {
	class = "super_nerd",
	name = "Miguel",
	pokemon = {
		{name = "grimer", level = 12, abilityList = nil},
		{name = "voltorb", level = 12, abilityList = nil},
		{name = "koffing", level = 12, abilityList = nil}
	},
	preBattle = {
		"Hey, stop!",
		"I found these fossils! They're both mine!"
	},
	postBattle = {
		"Okay! I'll share!"
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
		"Stop right there, Kid!",
		"You're ten thousand light-years from facing BROCK!"
	},
	postBattle = {
		"Dang!",
		"Light-years isn't time... It measures distance!"
	},
	reward = 288
}

local tBROCK = {
	class = "Brock",
	name = "",
	pokemon = {
		{name = "geodude", level = 10, abilityList = {"tackle", "defense_curl"}},
		{name = "onix", level = 11, abilityList = {"tackle","harden","rock_throw"}}
	},
	preBattle = {
		"I'm Brock! I'm Pewter's Gym Leader!",
		"I believe in rock hard defense and determination!",
		"That's why my Pokémon are all the Rock-type!",
		"Do you still want to challenge me?",
		"Fine then! Show me your best!"
	},
	postBattle = {
		"I took you for granted.",
		"As proof of your victory, here's the BoulderBadge!"
	},
	reward = 288
}

--------------------------------------------------------------------------------
-- Route 24
--------------------------------------------------------------------------------

local tBUG_CATCHER11 = {
	class = "bug_catcher",
	name = "Cale",
	pokemon = {
		{name = "caterpie", level = 10, abilityList = nil},
		{name = "weedle", level = 10, abilityList = nil},
		{name = "metapod", level = 10, abilityList = {"tackle","harden"}},
		{name = "kakuna", level = 10, abilityList = {"tackle","harden"}}
	},
	preBattle = {
		"People call this the NUGGET BRIDGE!",
		"Beat us five TRAINERS and win a fabulous prize!",
		"Think you got what it takes?"
	},
	postBattle = {
		"Whoo! Great stuff!"
	},
	reward = 120
}

local tLASS6 = {
	class = "lass",
	name = "Ali",
	pokemon = {
		{name = "pidgey", level = 12, abilityList = nil},
		{name = "oddish", level = 12, abilityList = nil},
		{name = "bellsprout", level = 12, abilityList = nil},
	},
	preBattle = {
		"I'm second! Now it's serious!"
	},
	postBattle = {
		"How could I lose?"
	},
	reward = 192
}

local tYOUNGSTER4 = {
	class = "Youngster",
	name = "Timmy",
	pokemon = {
		{name = "sandshrew", level = 14, abilityList = nil},
		{name = "ekans", level = 14, abilityList = nil}
	},
	preBattle = {
		"Here's No. 3! I won't be easy!"
	},
	postBattle = {
		"Ow! Stomped flat!"
	},
	reward = 224
}

local tLASS7 = {
	class = "lass",
	name = "Reli",
	pokemon = {
		{name = "nidoran_f", level = 16, abilityList = nil},
		{name = "nidoran_m", level = 16, abilityList = nil}
	},
	preBattle = {
		"I'm No. 4! Getting tired?"
	},
	postBattle = {
		"I lost too!"
	},
	reward = 256
}

local tCAMPER2 = {
	class = "camper",
	name = "Ethan",
	pokemon = {
		{name = "mankey", level = 18, abilityList = nil}
	},
	preBattle = {
		"Okay! I'm No. 5! I'll stomp you!"
	},
	postBattle = {
		"Whoa! Too much!"
	},
	reward = 360
}

local tROCKET_GRUNT5 = {
	class = "rocket_grunt",
	name = "",
	pokemon = {
		{name = "ekans", level = 15, abilityList = nil},
		{name = "zubat", level = 15, abilityList = nil}
	},
	preBattle = {
		"Congratulations! You beat our five contest TRAINERS!",
		"You just earned a fabulous prize!",
		"By the way, how would you like to join TEAM ROCKET?",
		"We're a group of professional criminals specializing in POKEMON!",
		"Want to join?",
		"Are you sure?",
		"Come on, join us!",
		"I'm telling you to join!",
		"...Okay, you need convincing!",
		"I'll make you an offer you can't refuse!"
	},
	postBattle = {
		"You're good!",
		"With your ability, you'd become a top leader in TEAM ROCKET.",
		"Come on, think of the opportunity!",
		"Don't let this chance go to waste."
	},
	reward = 480
}

local tCAMPER3 = {
	class = "camper",
	name = "Shane",
	pokemon = {
		{name = "rattata", level = 14, abilityList = nil},
		{name = "ekans", level = 14, abilityList = nil}
	},
	preBattle = {
		"I saw your feet from the grass!"
	},
	postBattle = {
		"I thought not!"
	},
	reward = 280
}

--------------------------------------------------------------------------------
-- Route 25
--------------------------------------------------------------------------------
local tHIKER2 = {
	class = "Hiker",
	name = "Franklin",
	pokemon = {
		{name = "machop", level = 15, abilityList = nil},
		{name = "geodude", level = 15, abilityList = nil}
	},
	preBattle = {
		"I just got down from MT. MOON, but I've still got gas in the tank!"
	},
	postBattle = {
		"You worked hard!"
	},
	reward = 540
}

local tHIKER3 = {
	class = "Hiker",
	name = "Wayne",
	pokemon = {
		{name = "onix", level = 17, abilityList = nil}
	},
	preBattle = {
		"You're going to see BILL? First, we battle!"
	},
	postBattle = {
		"You're something."
	},
	reward = 612
}

local tYOUNGSTER5 = {
	class = "Youngster",
	name = "Joey",
	pokemon = {
		{name = "rattata", level = 15, abilityList = nil},
		{name = "spearow", level = 15, abilityList = nil}
	},
	preBattle = {
		"Local TRAINERS come here to practice."
	},
	postBattle = {
		"You're decent."
	},
	reward = 240
}

local tYOUNGSTER6 = {
	class = "Youngster",
	name = "Dan",
	pokemon = {
		{name = "slowpoke", level = 17, abilityList = nil}
	},
	preBattle = {
		"Dad took me to a great party on the S.S. ANNE at VERMILION CITY."
	},
	postBattle = {
		"I'm not mad!"
	},
	reward = 272
}

local tPICNICKER1 = {
	class = "Picnicker",
	name = "Kelsey",
	pokemon = {
		{name = "nidoran_f", level = 15, abilityList = nil},
		{name = "nidoran_m", level = 15, abilityList = nil}
	},
	preBattle = {
		"Hi! My boyfriend is cool!"
	},
	postBattle = {
		"My conditionig isn't the best..."
	},
	reward = 300
}

local tHIKER4 = {
	class = "Hiker",
	name = "Nob",
	pokemon = {
		{name = "geodude", level = 13, abilityList = nil},
		{name = "geodude", level = 13, abilityList = nil},
		{name = "machop", level = 13, abilityList = nil},
		{name = "geodude", level = 13, abilityList = nil}
	},
	preBattle = {
		"I'm off to see a POKEMANIAC's collection at the cape."
	},
	postBattle = {
		"You done got me, and real good, too!"
	},
	reward = 468
}

local tCAMPER4 = {
	class = "Camper",
	name = "Flint",
	pokemon = {
		{name = "rattata", level = 14, abilityList = nil},
		{name = "ekans", level = 14, abilityList = nil}
	},
	preBattle = {
		"I'm a cool guy. I've got a girlfriend!"
	},
	postBattle = {
		"Aw, darn..."
	},
	reward = 280
}

local tYOUNGSTER7 = {
	class = "Youngster",
	name = "Chad",
	pokemon = {
		{name = "ekans", level = 14, abilityList = nil},
		{name = "sandshrew", level = 14, abilityList = nil}
	},
	preBattle = {
		"I had this feeling... I knew I had to battle you!"
	},
	postBattle = {
		"I knew I'd lose, too!"
	},
	reward = 224
}

local tLASS8 = {
	class = "Lass",
	name = "Haley",
	pokemon = {
		{name = "oddish", level = 13, abilityList = nil},
		{name = "pidgey", level = 13, abilityList = nil},
		{name = "oddish", level = 13, abilityList = nil}
	},
	preBattle = {
		"My friend has many cute POKEMON. I'm so jealous!"
	},
	postBattle = {
		"I'm not so jealous!"
	},
	reward = 208
}

--------------------------------------------------------------------------------
-- Cerulean Gym
--------------------------------------------------------------------------------
local tSWIMMER1 = {
	class = "Swimmer",
	name = "Luis",
	pokemon = {
		{name = "horsea", level = 16, abilityList = nil},
		{name = "shellder", level = 16, abilityList = nil}
	},
	preBattle = {
		"Splash!"
	},
	postBattle = {
		"That can't be!"
	},
	reward = 64
}

local tPICNICKER2 = {
	class = "Picnicker",
	name = "Diana",
	pokemon = {
		{name = "goldeen", level = 19, abilityList = nil}
	},
	preBattle = {
		"What? You? I'm more than good enough for you!"
	},
	postBattle = {
		"You overwhelmed me!",
		"You have to face other TRAINERS to see how good you really are."
	},
	reward = 380
}

local tMISTY = {
	class = "Misty",
	name = "",
	pokemon = {
		{name = "staryu", level = 18, abilityList = {"tackle","harden","recover","bubble_beam"}},
		{name = "starmie", level = 21, abilityList = {"rapid_spin","swift","recover","bubble_beam"}}
	},
	preBattle = {
		"Hi, you're a new face!",
		"Only those TRAINERS who have a policy about POKEMON can turn pro.",
		"What is your approach when you catch and train POKEMON?",
		"My policy is an all out offensive with WATER-type POKEMON!"
	},
	postBattle = {
		"Wow!, You're too much, all right!",
		"You can have the CASCADE BADGE to show that you beat me.",
		"CONGRATULATIONS! You have beaten the demo!",
		"More content is coming soon!"
	},
	reward = 2100
}

--------------------------------------------------------------------------------
-- Route 6
--------------------------------------------------------------------------------
local tBUG_CATCHER12 = {
	class = "bug_catcher",
	name = "Keigo",
	pokemon = {
		{name = "weedle", level = 16, abilityList = nil},
		{name = "caterpie", level = 16, abilityList = nil},
		{name = "weedle", level = 16, abilityList = nil}
	},
	preBattle = {
		"There aren't many bugs out here."
	},
	postBattle = {
		"No! You're kidding!"
	},
	reward = 192
}

local tCAMPER5 = {
	class = "Camper",
	name = "Ricky",
	pokemon = {
		{name = "squirtle", level = 20, abilityList = nil}
	},
	preBattle = {
		"Who's there? Quit listening in on us!"
	},
	postBattle = {
		"I just can't win!"
	},
	reward = 400
}

local tPICNICKER3 = {
	class = "Picnicker",
	name = "Nancy",
	pokemon = {
		{name = "rattata", level = 16, abilityList = nil},
		{name = "pikachu", level = 16, abilityList = nil}
	},
	preBattle = {
		"Excuse me! This is a private conversation!"
	},
	postBattle = {
		"Ugh! I hate losing!"
	},
	reward = 320
}

local tBUG_CATCHER13 = {
	class = "bug_catcher",
	name = "Elijah",
	pokemon = {
		{name = "butterfree", level = 20, abilityList = nil}
	},
	preBattle = {
		"I've never seen you around. Are you good?"
	},
	postBattle = {
		"You're too good!"
	},
	reward = 240
}

local tPICNICKER4 = {
	class = "Picnicker",
	name = "Isabelle",
	pokemon = {
		{name = "pidgey", level = 16, abilityList = nil},
		{name = "pidgey", level = 16, abilityList = nil},
		{name = "pidgey", level = 16, abilityList = nil}
	},
	preBattle = {
		"Me? Well okay, I'll play!"
	},
	postBattle = {
		"Things just didn't work..."
	},
	reward = 320
}

local tCAMPER6 = {
	class = "Camper",
	name = "Jeff",
	pokemon = {
		{name = "spearow", level = 16, abilityList = nil},
		{name = "raticate", level = 16, abilityList = nil}
	},
	preBattle = {
		"Huh? You want to talk to me?"
	},
	postBattle = {
		"This stinks... I couldn't beat your challenge..."
	},
	reward = 320
}

--------------------------------------------------------------------------------
-- Vermillion City Gym
--------------------------------------------------------------------------------
local tSAILOR1 = {
	class = "Sailor",
	name = "Dwayne",
	pokemon = {
		{name = "pikachu", level = 21, abilityList = nil},
		{name = "pikachu", level = 21, abilityList = nil}
	},
	preBattle = {
		"This is no place for kids! Not even if you're good!"
	},
	postBattle = {
		"Wow! Surprised me!"
	},
	reward = 672
}

local tENGINEER1 = {
	class = "Engineer",
	name = "Baily",
	pokemon = {
		{name = "voltorb", level = 21, abilityList = nil},
		{name = "magnemite", level = 21, abilityList = nil}
	},
	preBattle = {
		"I'm a lightweight, but I'm good with electricity!",
		"That's why I joined this GYM."
	},
	postBattle = {
		"Fried!"
	},
	reward = 1008
}

local tGENTLEMAN1 = {
	class = "Gentleman",
	name = "Baily",
	pokemon = {
		{name = "pikachu", level = 23, abilityList = nil}
	},
	preBattle = {
		"When I was in the Army, LT. SURGE was my strict CO.",
		"He was a hard taskmaster"
	},
	postBattle = {
		"Stop! You're very good!"
	},
	reward = 1656
}

local tLT_SURGE = {
	class = "lt_surge",
	name = "",
	pokemon = {
		{name = "voltorb", level = 21, abilityList = nil},
		{name = "pikachu", level = 18, abilityList = nil},
		{name = "raichu", level = 24, abilityList = nil}
	},
	preBattle = {
		"Hey, kid! What do you think you're doing here?",
		"You won't live long in combat! Not with your puny power!",
		"I tell you, kid, electric POKEMON saved me during the war!",
		"They zapped my enemies into paralysis!",
		"The same as I'll do to you!"
	},
	postBattle = {
		"Fine then, take the THUNDER BADGE!"
	},
	reward = 2400
}

--------------------------------------------------------------------------------
-- Route 11
--------------------------------------------------------------------------------
local tYOUNGSTER8 = {
	class = "Youngster",
	name = "Eddie",
	pokemon = {
		{name = "ekans", level = 21, abilityList = nil}
	},
	preBattle = {
		"Let's go, but don't cheat!"
	},
	postBattle = {
		"Huh? That's not right!"
	},
	reward = 336
}

local tGAMER1 = {
	class = "Gamer",
	name = "Hugo",
	pokemon = {
		{name = "poliwag", level = 18, abilityList = nil},
		{name = "horsea", level = 18, abilityList = nil}
	},
	preBattle = {
		"<Placeholder>"
	},
	postBattle = {
		"<Placeholder>"
	},
	reward = 1296
}

local tENGINEER2 = {
	class = "Engineer",
	name = "Bernie",
	pokemon = {
		{name = "magnemite", level = 18, abilityList = nil},
		{name = "magnemite", level = 18, abilityList = nil},
		{name = "magnemite", level = 18, abilityList = nil}
	},
	preBattle = {
		"<Placeholder>"
	},
	postBattle = {
		"<Placeholder>"
	},
	reward = 864
}

local tYOUNGSTER9 = {
	class = "Youngster",
	name = "Dave",
	pokemon = {
		{name = "nidoran_m", level = 18, abilityList = nil},
		{name = "nidorino", level = 18, abilityList = nil}
	},
	preBattle = {
		"I raised my POKEMON carefully. They should be ready by now!"
	},
	postBattle = {
		"Bye-bye! Thank you, and good-bye!"
	},
	reward = 288
}

local tYOUNGSTER10 = {
	class = "Youngster",
	name = "Dillon",
	pokemon = {
		{name = "sandshrew", level = 19, abilityList = nil},
		{name = "zubat", level = 19, abilityList = nil}
	},
	preBattle = {
		"I just became a trainer. But, I think I can win!"
	},
	postBattle = {
		"My POKEMON couldn't win... Haven't they grown enough?"
	},
	reward = 304
}

local tGAMER2 = {
	class = "Gamer",
	name = "Jasper",
	pokemon = {
		{name = "bellsprout", level = 18, abilityList = nil},
		{name = "oddish", level = 18, abilityList = nil}
	},
	preBattle = {
		"<Placeholder>"
	},
	postBattle = {
		"<Placeholder>"
	},
	reward = 1296
}

local tENGINEER3 = {
	class = "Engineer",
	name = "Braxton",
	pokemon = {
		{name = "magnemite", level = 21, abilityList = nil}
	},
	preBattle = {
		"Careful! I'm laying down some cables!"
	},
	postBattle = {
		"That was electric!"
	},
	reward = 1008
}

local tGAMER3 = {
	class = "Gamer",
	name = "Darian",
	pokemon = {
		{name = "growlithe", level = 18, abilityList = nil},
		{name = "vulpix", level = 18, abilityList = nil}
	},
	preBattle = {
		"<Placeholder>"
	},
	postBattle = {
		"<Placeholder>"
	},
	reward = 1296
}

local tYOUNGSTER11 = {
	class = "Youngster",
	name = "Yasu",
	pokemon = {
		{name = "rattata", level = 17, abilityList = nil},
		{name = "rattata", level = 17, abilityList = nil},
		{name = "raticate", level = 17, abilityList = nil}
	},
	preBattle = {
		"<Placeholder>"
	},
	postBattle = {
		"<Placeholder>"
	},
	reward = 272
}

local tGAMER3 = {
	class = "Gamer",
	name = "Dirk",
	pokemon = {
		{name = "voltorb", level = 18, abilityList = nil},
		{name = "magnemite", level = 18, abilityList = nil}
	},
	preBattle = {
		"Fwahaha! I've never lost!"
	},
	postBattle = {
		"My first loss!"
	},
	reward = 1296
}

--------------------------------------------------------------------------------
-- S.S. Anne (Deck)
--------------------------------------------------------------------------------
local tSAILOR2 = {
	class = "Sailor",
	name = "Trevor",
	pokemon = {
		{name = "machop", level = 17, abilityList = nil},
		{name = "tentacool", level = 17, abilityList = nil}
	},
	preBattle = {
		"Ahoy, there! Are you seasick?"
	},
	postBattle = {
		"I was just careless!"
	},
	reward = 544
}

local tSAILOR3 = {
	class = "Sailor",
	name = "Trevor",
	pokemon = {
		{name = "machop", level = 18, abilityList = nil},
		{name = "shellder", level = 18, abilityList = nil}
	},
	preBattle = {
		"Hey, matey! Let's do a little jig!"
	},
	postBattle = {
		"You're impressive!"
	},
	reward = 576
}

--------------------------------------------------------------------------------
-- S.S. Anne (B1f)
--------------------------------------------------------------------------------
local tFISHERMAN1 = {
	class = "fisherman",
	name = "Barny",
	pokemon = {
		{name = "tentacool", level = 17, abilityList = nil},
		{name = "staryu", level = 17, abilityList = nil},
		{name = "shellder", level = 17, abilityList = nil}
	},
	preBattle = {
		"I can't tell if you're from the seas or mountains, but stop and chat.",
		"All my POKEMON are from the sea."
	},
	postBattle = {
		"Darn! I let that one get away from me!"
	},
	reward = 612
}

local tSAILOR4 = {
	class = "Sailor",
	name = "Phillip",
	pokemon = {
		{name = "machop", level = 20, abilityList = nil}
	},
	preBattle = {
		"Even us sailors have POKEMON, too!"
	},
	postBattle = {
		"Okay, you're not bad."
	},
	reward = 640
}

local tSAILOR5 = {
	class = "Sailor",
	name = "Huey",
	pokemon = {
		{name = "tentacool", level = 18, abilityList = nil},
		{name = "staryu", level = 18, abilityList = nil}
	},
	preBattle = {
		"I like fesity kids like you!"
	},
	postBattle = {
		"Argh, lost it!"
	},
	reward = 576
}

local tSAILOR6 = {
	class = "Sailor",
	name = "Duncan",
	pokemon = {
		{name = "horsea", level = 17, abilityList = nil},
		{name = "shellder", level = 17, abilityList = nil},
		{name = "horsea", level = 17, abilityList = nil}
	},
	preBattle = {
		"Come on, then! My sailor's pride is at stake!"
	},
	postBattle = {
		"You sunk me!"
	},
	reward = 544
}

local tSAILOR7 = {
	class = "Sailor",
	name = "Leonard",
	pokemon = {
		{name = "shellder", level = 21, abilityList = nil}
	},
	preBattle = {
		"You know what they say about sailors and battling!"
	},
	postBattle = {
		"Right! Good battle, mate!"
	},
	reward = 672
}

--------------------------------------------------------------------------------
-- S.S Anne (1F)
--------------------------------------------------------------------------------
local tGENTLEMAN2 = {
	class = "Gentleman",
	name = "Thomas",
	pokemon = {
		{name = "growlithe", level = 18, abilityList = nil},
		{name = "growlithe", level = 18, abilityList = nil}
	},
	preBattle = {
		"My sole companions and friends are POKEMON I caught on my journeys..."
	},
	postBattle = {
		"My, my friends..."
	},
	reward = 1296
}

local tGENTLEMAN3 = {
	class = "Gentleman",
	name = "Arthur",
	pokemon = {
		{name = "nidoran_m", level = 19, abilityList = nil},
		{name = "nidoran_f", level = 19, abilityList = nil}
	},
	preBattle = {
		"You insolent pup! How dare you charge in!"
	},
	postBattle = {
		"Humph! You rude child! You have no sense of courtesy!"
	},
	reward = 1368
}

local tLASS9 = {
	class = "Lass",
	name = "Ann",
	pokemon = {
		{name = "pidgey", level = 18, abilityList = nil},
		{name = "nidoran_f", level = 18, abilityList = nil}
	},
	preBattle = {
		"I collected all these pokemon from around the world!"
	},
	postBattle = {
		"Oh, no! I went around the world for these!"
	},
	reward = 288
}

local tYOUNGSTER12 = {
	class = "Youngster",
	name = "Tyler",
	pokemon = {
		{name = "nidoran_m", level = 21, abilityList = nil}
	},
	preBattle = {
		"I love POKEMON! Do you?"
	},
	postBattle = {
		"Wow! You're great!"
	},
	reward = 336
}

--------------------------------------------------------------------------------
-- S.S. Anne (2F)
--------------------------------------------------------------------------------
local tFISHERMAN2 = {
	class = "fisherman",
	name = "Dale",
	pokemon = {
		{name = "goldeen", level = 17, abilityList = nil},
		{name = "goldeen", level = 17, abilityList = nil},
		{name = "tentacool", level = 17, abilityList = nil}
	},
	preBattle = {
		"Check out what I fished up!"
	},
	postBattle = {
		"I'm all out!"
	},
	reward = 612
}

local tGENTLEMAN4 = {
	class = "Gentleman",
	name = "Brooks",
	pokemon = {
		{name = "pikachu", level = 23, abilityList = nil}
	},
	preBattle = {
		"Competing against the young keeps me youthful."
	},
	postBattle = {
		"Good match! Ah, I feel young again!"
	},
	reward = 1656
}

local tLASS10 = {
	class = "Lass",
	name = "Dawn",
	pokemon = {
		{name = "rattata", level = 18, abilityList = nil},
		{name = "pikachu", level = 18, abilityList = nil}
	},
	preBattle = {
		"I don't believe I saw you at the party?"
	},
	postBattle = {
		"Take it easy!"
	},
	reward = 288
}

local tGENTLEMAN5 = {
	class = "Gentleman",
	name = "Lamar",
	pokemon = {
		{name = "growlithe", level = 17, abilityList = nil},
		{name = "ponyta", level = 17, abilityList = nil}
	},
	preBattle = {
		"Which do you find more worthy, a strong or a rare POKEMON?"
	},
	postBattle = {
		"I must salute you!"
	},
	reward = 1224
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
	bug_catcher8 = tBUG_CATCHER9,
	bug_catcher10 = tBUG_CATCHER10,
	bug_catcher11 = tBUG_CATCHER11,
	bug_catcher12 = tBUG_CATCHER12,
	bug_catcher13 = tBUG_CATCHER13,
	lass1 = tLASS1,
	lass2 = tLASS2,
	lass3 = tLASS3,
	lass4 = tLASS4,
	lass5 = tLASS5,
	lass6 = tLASS6,
	lass7 = tLASS7,
	lass8 = tLASS8,
	lass9 = tLASS9,
	lass10 = tLASS10,
	youngster1 = tYOUNGSTER1,
	youngster2 = tYOUNGSTER2,
	youngster3 = tYOUNGSTER3,
	youngster4 = tYOUNGSTER4,
	youngster5 = tYOUNGSTER5,
	youngster6 = tYOUNGSTER6,
	youngster7 = tYOUNGSTER7,
	youngster8 = tYOUNGSTER8,
	youngster9 = tYOUNGSTER9,
	youngster10 = tYOUNGSTER10,
	youngster11 = tYOUNGSTER11,
	youngster12 = tYOUNGSTER12,
	super_nerd1 = tSUPER_NERD1,
	super_nerd2 = tSUPER_NERD2,
	rocket_grunt1 = tROCKET_GRUNT1,
	rocket_grunt2 = tROCKET_GRUNT2,
	rocket_grunt3 = tROCKET_GRUNT3,
	rocket_grunt4 = tROCKET_GRUNT4,
	rocket_grunt5 = tROCKET_GRUNT5,
	hiker1 = tHIKER1,
	hiker2 = tHIKER2,
	hiker3 = tHIKER3,
	hiker4 = tHIKER4,
	camper1 = tCAMPER1,
	camper2 = tCAMPER2,
	camper3 = tCAMPER3,
	camper4 = tCAMPER4,
	camper5 = tCAMPER5,
	camper6 = tCAMPER6,
	picnicker1 = tPICNICKER1,
	picnicker2 = tPICNICKER2,
	picnicker3 = tPICNICKER3,
	picnicker4 = tPICNICKER4,
	swimmer1 = tSWIMMER1,
	sailor1 = tSAILOR1,
	sailor2 = tSAILOR2,
	sailor3 = tSAILOR3,
	sailor4 = tSAILOR4,
	sailor5 = tSAILOR5,
	sailor6 = tSAILOR6,
	sailor7 = tSAILOR7,
	gentleman1 = tGENTLEMAN1,
	gentleman2 = tGENTLEMAN2,
	gentleman3 = tGENTLEMAN3,
	gentleman4 = tGENTLEMAN4,
	gentleman5 = tGENTLEMAN5,
	gamer1 = tGAMER1,
	gamer2 = tGAMER2,
	gamer3 = tGAMER3,
	fisherman1 = tFISHERMAN1,
	fisherman2 = tFISHERMAN2,

	brock = tBROCK,
	misty = tMISTY,
	lt_surge = tLT_SURGE
}

local test = {
	youngster_joey = tTEST_TRAINER
}

--return test
return tTRAINERS_ALL
