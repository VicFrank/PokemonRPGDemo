-- This is the primary barebones gamemode script and should be used to assist in initializing your game mode


-- Set this to true if you want to see a complete debug output of all events/processes done by barebones
-- You can also change the cvar 'barebones_spew' at any time to 1 or 0 for output/no output
BAREBONES_DEBUG_SPEW = false
PLAYER_BUTTON_TABLE = {}           -- If we're not automatically setting the number of players per team, use this table
PLAYER_BUTTON_TABLE[DOTA_TEAM_GOODGUYS] = nil
PLAYER_BUTTON_TABLE[DOTA_TEAM_BADGUYS]  = nil
PLAYER_BUTTON_TABLE[DOTA_TEAM_CUSTOM_1] = nil
PLAYER_BUTTON_TABLE[DOTA_TEAM_CUSTOM_2] = nil
PLAYER_BUTTON_TABLE[DOTA_TEAM_CUSTOM_3] = nil
PLAYER_BUTTON_TABLE[DOTA_TEAM_CUSTOM_4] = nil
PLAYER_BUTTON_TABLE[DOTA_TEAM_CUSTOM_5] = nil
PLAYER_BUTTON_TABLE[DOTA_TEAM_CUSTOM_6] = nil
PLAYER_BUTTON_TABLE[DOTA_TEAM_CUSTOM_7] = nil
PLAYER_BUTTON_TABLE[DOTA_TEAM_CUSTOM_8] = nil

if GameMode == nil then
    DebugPrint( '[BAREBONES] creating barebones game mode' )
    _G.GameMode = class({})
end

-- This library allow for easily delayed/timed actions
require('libraries/timers')
-- This library can be used for advancted physics/motion/collision of units.  See PhysicsReadme.txt for more information.
require('libraries/physics')
-- This library can be used for advanced 3D projectile systems.
require('libraries/projectiles')
-- This library can be used for sending panorama notifications to the UIs of players/teams/everyone
require('libraries/notifications')
-- This library can be used for starting customized animations on units from lua
require('libraries/animations')

-- These internal libraries set up barebones's events and processes.  Feel free to inspect them/change them if you need to.
require('internal/gamemode')
require('internal/events')

-- settings.lua is where you can specify many different properties for your game mode and is one of the core barebones files.
require('settings')
-- events.lua is where you can specify the actions to be taken when any event occurs and is one of the core barebones files.
require('events')

require('pokemon')
require('libraries/pokehelper')

-- Perry said this works
--LinkLuaModifier( "modifier_ignore_cast_angle", "LuaModifiers/modifier_ignore_cast_angle.lua", LUA_MODIFIER_MOTION_NONE )

--[[
  This function should generally only be used if the Precache() function in addon_game_mode.lua is not working.
]]
function GameMode:PostLoadPrecache()
  DebugPrint("[BAREBONES] Performing Post-Load precache")    
  --PrecacheItemByNameAsync("item_example_item", function(...) end)
end

--[[
  This function is called once and only once as soon as the first player (almost certain to be the server in local lobbies) loads in.
  It can be used to initialize state that isn't initializeable in InitGameMode() but needs to be done before everyone loads in.
]]
function GameMode:OnFirstPlayerLoaded()
  DebugPrint("[BAREBONES] First Player has loaded")
end

--[[
  This function is called once and only once after all players have loaded into the game, right as the hero selection time begins.
  It can be used to initialize non-hero player state or adjust the hero selection (i.e. force random etc)
]]
function GameMode:OnAllPlayersLoaded()
  DebugPrint("[BAREBONES] All Players have loaded into the game")
end

--[[
  This function is called once and only once for every player when they spawn into the game for the first time.  It is also called
  if the player's hero is replaced with a new hero for any reason.  This function is useful for initializing heroes, such as adding
  levels, changing the starting gold, removing/adding abilities, adding physics, etc.

  The hero parameter is the hero entity that just spawned in
]]
function GameMode:OnHeroInGame(hero)
	DebugPrint("[BAREBONES] Hero spawned in game for first time -- " .. hero:GetUnitName())

	-- These lines will create an item and add it to the player, effectively ensuring they start with the item
	local item = CreateItem("item_poke_ball", hero, hero)
	local item2 = CreateItem("item_poke_ball", hero, hero)
	--look up this pokemon's metadata, variable name is short to keep the intialization length reasonable
	local metadata = self.pokemon_table["bulbasaur"]
	local level = 5
	local abilityList = { "body_slam", "fury_attack", "leer", "bug_bite" }
	item.pokemon = PokeHelper:CreatePokemonFromMetadata(metadata, level, abilityList)
	metadata = self.pokemon_table["squirtle"]
	item2.pokemon = PokeHelper:CreatePokemonFromMetadata(metadata, level, abilityList)
	hero:AddItem(item)
	hero:AddItem(item2)
	
	hero.state = "Normal"
end

function GameMode:_ReadGameConfiguration()
	local kv = LoadKeyValues( "scripts/pokemon_table.txt" )
	kv = kv or {} -- Handle the case where there is not keyvalues file
	local kvPokemon = kv["Pokemon"]
	
	self.pokemon_table = {}
	
	if type( kvPokemon ) ~= "table" then
		return
	end
	for k,v in pairs( kvPokemon ) do
		local pokemonMetaData = {
			unitName = v.Name,
			type1 = v.Type1,
			type2 = v.Type2 or nil,
			baseHP = v.BaseHP,
			baseAttack = v.BaseAttack,
			baseDefense = v.BaseDefense,
			baseSpecialAttack = v.BaseSpecialAttack,
			baseSpecialDefense = v.BaseSpecialDefense,
			baseSpeed = v.BaseSpeed,
			evolution = v.Evolution,
			learnSet = v.LearnSet,
			expYield = v.ExpYield,
			catchRate = v.CatchRate
		}
		self.pokemon_table[v.Name] = pokemonMetaData
	end
	
	--initialize wild pokemon
	local metadata = self.pokemon_table["bulbasaur"]
	local level = 5
	local abilityList = { "bubble", "bite", "tail_whip", "withdraw" }
	
	for i=1,6 do
		local pokemon = PokeHelper:CreatePokemonFromMetadata(metadata, level, abilityList)
		local position = Entities:FindByName( nil, "spawner" .. i ):GetAbsOrigin()
		PokeHelper:CreatePokemonAtPosition( pokemon, position )
	end
end

function GameMode:BattleEnded( pokemonAvatar, defeatedPokemon, attackers, numAttackers )
	local pokemon = pokemonAvatar.pokemon
	local experience = PokeHelper:CalculateExp( pokemon, defeatedPokemon )
	local position = pokemonAvatar:GetAbsOrigin()
	local trainer = pokemonAvatar.trainer
	local team = trainer:GetTeam()
	experience = math.floor(experience / numAttackers)
	Notifications:RPGTextBox(0, {text="Enemy " .. defeatedPokemon:GetName() .. " was defeated!", duration=2, buttons=false, code=100, dialogueTree=""})
	--assign exp split evenly between contributing pokemon
	for k,_ in pairs( attackers ) do
		--check to see if any pokemon leveled up
		Notifications:RPGTextBox(0, {text=k:GetName() .. " gained " .. experience .. " experience.", duration=2, buttons=false, code=100, dialogueTree=""})
		local currentLevel = k:GetLevel()
		if k:AddExperience( experience ) then
			if k ~= pokemon then
				pokemonAvatar = PokeHelper:CreatePokemonAtPosition( k, position, trainer, team )
			end
			GameMode:LevelUp( pokemonAvatar, currentLevel )
		end
		--withdraw the current pokemon
		PokeHelper:Withdraw( pokemonAvatar.trainer )
	end
end

function GameMode:LevelUp( pokemonAvatar, previousLevel )
	local pokemon = pokemonAvatar.pokemon
	local currentLevel = pokemon:GetLevel()
	local metaData = self.pokemon_table[pokemon:GetUnitName()]
	pokemonAvatar:CreatureLevelUp(1)
	Notifications:RPGTextBox(0, {text=pokemon:GetName() .. " grew to level " .. currentLevel .. "!", duration=2, buttons=false, code=100, dialogueTree=""})
	--check to see if learned a new move
	local newAbilityList = {}
	for i=previousLevel,currentLevel do
		local newAbility = metaData.learnSet[tostring(i)]
		if newAbility ~= nil then
			table.insert(newAbilityList, newAbility)
		end
	end
	if #newAbilityList ~= 0 then
		for _,v in pairs( newAbilityList ) do
			GameMode:LearnNewMove( pokemonAvatar, v )
		end
	end
	--check to see if it evolved
	local evolveLevel = metaData.evolution.Level
	if evolveLevel ~= nil and pokemon:GetLevel() >= evolveLevel then
		GameMode:Evolve( pokemonAvatar )
	end
end

function GameMode:Evolve( pokemonAvatar )
	local pokemon = pokemonAvatar.pokemon
	local currentPMetaData = self.pokemon_table[pokemon:GetUnitName()]
	local p = self.pokemon_table[currentPMetaData.evolution.NextEvolution]
	Notifications:RPGTextBox(0, {text=pokemon:GetName() .. " is evolving!", duration=2, buttons=false, code=101, dialogueTree=""})
	pokemon:Evolve(p.unitName, p.type1, p.type2, p.baseAttack, p.baseDefense, p.baseSpecialAttack, p.baseSpecialDefense, p.baseSpeed, p.baseHP, p.baseExpYield)
end

function GameMode:LearnNewMove( pokemonAvatar, newAbilityName )
	local pokemon = pokemonAvatar.pokemon
	local metaData = self.pokemon_table[pokemon:GetUnitName()]
	pokemon:AddAbility(newAbilityName)
	pokemonAvatar:AddAbility(newAbilityName)
	local abilityList = {}
	for i=0,3 do
		if pokemonAvatar:GetAbilityByIndex(i) ~= nil then
			print(pokemonAvatar:GetAbilityByIndex(i):entindex())
			abilityList[i] = pokemonAvatar:GetAbilityByIndex(i):entindex()
		else
			break
		end
	end
	--if the pokemon already knows 4 moves
	if i == 3 then
		Notifications:RPGTextBox(0, {text=pokemon:GetName() .. " wants to learn " .. newAbilityName .. " but " .. pokemon:GetName() .. " already knows 4 moves!", duration=2, buttons=false, code=102, dialogueTree=""})
		Notifications:RPGTextBox(0, {text="Should a move be forgotten to make space for " .. newAbilityName .. "?", duration=-1, buttons=true, code=103, dialogueTree=""})
		Notifications:RPGTextBox(0, {text="Which move should be forgotten?", duration=-1, buttons=false, code=104, dialogueTree="yes", abilityList=abilityList}) --this is the new ability code
		Notifications:RPGTextBox(0, {text="1, 2 and... Poof! " .. pokemon:GetName() .. " forgot an old move and... " .. pokemon:GetName() .. " learned " .. newAbilityName .. "!", duration=2, buttons=false, code=105, dialogueTree="yes"})
		Notifications:RPGTextBox(0, {text=pokemon:GetName() .. " did not learn " .. newAbilityName .. ".", duration=2, buttons=false, code=106, dialogueTree="no"})		
	end
end

function GameMode:DeleteAbility( args )
	local playerID = args['player_id']
	local abilityName = args['ability_to_delete']
	local player = PlayerResource:GetPlayer(playerID)
	local pokemonAvatar = player.currentAvatar
	local pokemon = player.currentAvatar.pokemon
	pokemon:RemoveAbility(abilityName)
	pokemonAvatar:RemoveAbility(abilityName)
end

--helper function that generates the abilityID for JS by creating a dummy unit
function GameMode:GetAbilityIDByName( abilityName )
	
end

--[[
  This function is called once and only once when the game completely begins (about 0:00 on the clock).  At this point,
  gold will begin to go up in ticks if configured, creeps will spawn, towers will become damageable etc.  This function
  is useful for starting any game logic timers/thinkers, beginning the first round, etc.
]]
function GameMode:OnGameInProgress()
  DebugPrint("[BAREBONES] The game has officially begun")
  Timers:CreateTimer(0, -- Start this timer 30 game-time seconds later
    function()
      DebugPrint("This function is called 30 seconds after the game begins, and every 30 seconds thereafter")
		
      return 10.0 -- Rerun this timer every 30 game-time seconds 
    end)
end

-- This function initializes the game mode and is called before anyone loads into the game
-- It can be used to pre-initialize any values/tables that will be needed later
function GameMode:InitGameMode()
  GameMode = self
  DebugPrint('[BAREBONES] Starting to load Barebones gamemode...')
  --load the data from the KV files
  GameMode:_ReadGameConfiguration()

  -- Call the internal function to set up the rules/behaviors specified in constants.lua
  -- This also sets up event hooks for all event handlers in events.lua
  -- Check out internals/gamemode to see/modify the exact code
  GameMode:_InitGameMode()
  
  -- custom listeners from panorama are here, because I'm not sure where BMD would put them
  CustomGameEventManager:RegisterListener( "delete_ability", Dynamic_Wrap(GameMode, "DeleteAbility") )

  DebugPrint('[BAREBONES] Done loading Barebones gamemode!\n\n')
end