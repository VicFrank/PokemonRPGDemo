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
require('libraries/selection')

-- These internal libraries set up barebones's events and processes.  Feel free to inspect them/change them if you need to.
require('internal/gamemode')
require('internal/events')

-- settings.lua is where you can specify many different properties for your game mode and is one of the core barebones files.
require('settings')
-- events.lua is where you can specify the actions to be taken when any event occurs and is one of the core barebones files.
require('events')

require('pokemon')
require('libraries/pokehelper')
require('rpg_example_spawning')

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

	local starters = {"bulbasaur","squirtle","charmander"}

	for i=1,3 do
		local starter = starters[i]
		local item = CreateItem("item_poke_ball", hero, hero)
		local metadata = self.pokemon_table[starter]
		local level = 5
		local modelPosition = Entities:FindByName(nil, starter .. "_model"):GetAbsOrigin() 
		local itemPosition = Entities:FindByName(nil, starter .. "_item"):GetAbsOrigin() 

		item.pokemon = PokeHelper:CreatePokemonFromMetadata(metadata, level, false)

		CreateUnitByName(starter, modelPosition, false, nil, nil, DOTA_TEAM_NEUTRALS)
		CreateItemOnPositionSync(itemPosition, item)
	end
	
	--[[
	local item = CreateItem("item_poke_ball", hero, hero)
	local metadata = self.pokemon_table["pidgeot"]
	local level = 36
	--local abilityList = { "recover", "pound", "absorb", "leech_life" }
	--item.pokemon = PokeHelper:CreatePokemonFromMetadata(metadata, level, false, abilityList)
	item.pokemon = PokeHelper:CreatePokemonFromMetadata(metadata, level, false)
	hero:AddItem(item)
	]]
	
	hero:SetAbilityPoints(0)
	hero:AddAbility("throw_poke_ball")
	local ability = hero:FindAbilityByName("throw_poke_ball")
	ability:UpgradeAbility(true)
	
	PokeHelper:ApplyModifier( hero, "modifier_no_health_bar" )
	
	--currently the player has three states "Normal" "Battle" "PostBattle"
	hero.state = "Normal"
	hero.location = "pallet_town"
	hero.respawn = "pallet_town"
	hero:SetGold(500, false)
	
	--initialize the party screen
	CustomGameEventManager:Send_ServerToPlayer(hero:GetPlayerOwner(), "update_party_panel_response", PokeHelper:GetPartyData( hero ) )

	--[[
	hero:AddAbility("antimage_blink")
	local ability = hero:FindAbilityByName("antimage_blink")
	ability:UpgradeAbility(true)
	]]

	--[[
	Timers:CreateTimer(5, 
    function()
		if hero.pokemonAvatar ~= nil then
			local pokemon = hero.pokemonAvatar.pokemon
			local currentLevel = pokemon:GetLevel()
			if pokemon:AddExperience( pokemon:GetExpToNextLevel() + 1 ) then
				GameMode:LevelUp( hero.pokemonAvatar, currentLevel )
			end
		end
      return 5
    end)
	]]
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
		local pokemonMetadata = {
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
		self.pokemon_table[v.Name] = pokemonMetadata
	end
	
	GameMode:SetupSpawners()
end

--after a pokemon is defeated, calculate how much experience should be rewarded to each participating pokemon
function GameMode:DistributeExp( defeatedPokemon, attackers, experienceTable )
	if experienceTable == nil then
		experienceTable = {}
	end

	local numAttackers = 0

	if (attackers == nil) then
		print("attackers is nil")
		return {}
	end

	for k,v in pairs( attackers ) do
		numAttackers = numAttackers + 1
	end

	for contributingPokemon,_ in pairs( attackers ) do
		local experience = math.floor(PokeHelper:CalculateExp( contributingPokemon, defeatedPokemon ) / numAttackers)
		if experienceTable[contributingPokemon] == nil then
			experienceTable[contributingPokemon] = 0
		end
		experienceTable[contributingPokemon] = experienceTable[contributingPokemon] + experience
	end 

	return experienceTable
end

--give the experience in table to respective pokemon, deal with 
function GameMode:RewardExp( trainer, experienceTable )
	local team = trainer:GetTeam()
	local player = trainer:GetPlayerID()
	local position = PokeHelper:FindSpaceWithinRange( trainer:GetAbsOrigin(), 100, 200 )
	local delay = 0

	trainer.state = "PostBattle"
	PokeHelper:Withdraw( trainer )

	for contributingPokemon,experience in pairs( experienceTable ) do
		Notifications:RPGTextBox(player, {text=contributingPokemon:GetName() .. " gained " .. experience .. " experience.", duration=2, buttons=false, code=100, dialogueTree=""})
		delay = delay + 2
		local currentLevel = contributingPokemon:GetLevel()
		if contributingPokemon:AddExperience( experience ) then
			--create an avatar we can extract information from (like ability entindexes)
			local pokemonAvatar = PokeHelper:CreatePokemonAtPosition( contributingPokemon, position, trainer, team )
			GameMode:LevelUp( pokemonAvatar, currentLevel )
			delay = delay + 2
			if trainer.state ~= "LearningNewMove" then
				PokeHelper:Withdraw( trainer )
			end
		end
	end

	return delay
end

function GameMode:LevelUp( pokemonAvatar, previousLevel )
	local pokemon = pokemonAvatar.pokemon
	local currentLevel = pokemon:GetLevel()
	local trainer = pokemonAvatar.trainer
	local player = trainer:GetPlayerID()
	local metaData = self.pokemon_table[pokemon:GetUnitName()]
	
	Notifications:RPGTextBox(player, {text=pokemon:GetName() .. " grew to level " .. currentLevel .. "!", duration=2, buttons=false, code=100, dialogueTree=""})
	--check to see if we learned a new move
	local newAbilityList = {}
	for i=previousLevel+1,currentLevel do
		local newAbility = metaData.learnSet[tostring(i)]
		if newAbility ~= nil and pokemonAvatar:FindAbilityByName(newAbility) == nil then
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
	local player = pokemonAvatar.trainer:GetPlayerID()
	local currentPMetaData = self.pokemon_table[pokemon:GetUnitName()]
	local p = self.pokemon_table[currentPMetaData.evolution.NextEvolution]
	local name = pokemon:GetName()
	
	Notifications:RPGTextBox(0, {text=name .. " is evolving!", duration=2, buttons=false, code=101, dialogueTree=""})
	pokemon:Evolve(p.unitName, p.type1, p.type2, p.baseAttack, p.baseDefense, p.baseSpecialAttack, p.baseSpecialDefense, p.baseSpeed, p.baseHP, p.baseExpYield)
	Notifications:RPGTextBox(0, {text="Congratulations! Your " .. name .. " evolved into " .. string.upper(pokemon:GetUnitName()) .. "!", duration=2, buttons=false, code=100, dialogueTree=""})
end

function GameMode:LearnNewMove( pokemonAvatar, newAbilityName )
	local pokemon = pokemonAvatar.pokemon
	local player = pokemonAvatar.trainer:GetPlayerID()
	--turn the ability name into something human readable (bug_catcher -> Bug Catcher)
	local readableName = newAbilityName:gsub("_", " ")
	readableName = readableName:gsub("^%l", string.upper)

	
	pokemon:AddAbility(newAbilityName)
	pokemonAvatar:AddAbility(newAbilityName)
	local abilityCount = 0
	for i=0,4 do
		if pokemonAvatar:GetAbilityByIndex(i) ~= nil then
			abilityCount = abilityCount + 1
		else
			break
		end
	end
	--if the pokemon already knows 4 moves
	if abilityCount > 4 then
		Notifications:RPGTextBox(player, {text=pokemon:GetName() .. " wants to learn " .. readableName .. " but " .. pokemon:GetName() .. " already knows 4 moves!", duration=2, buttons=false, code=102, dialogueTree=""})
		Notifications:RPGTextBox(player, {text="Should a move be forgotten to make space for " .. readableName .. "?", duration=-1, buttons=true, code=103, dialogueTree=""})
		Notifications:RPGTextBox(player, {text="Which move should be forgotten?", duration=-1, buttons=false, code=104, dialogueTree="yes", unit=pokemonAvatar:entindex()}) --this is the new ability code
		Notifications:RPGTextBox(player, {text="1, 2 and... Poof! " .. pokemon:GetName() .. " forgot an old move and... " .. pokemon:GetName() .. " learned " .. readableName .. "!", duration=2, buttons=false, code=105, dialogueTree="yes"})
		Notifications:RPGTextBox(player, {text=pokemon:GetName() .. " did not learn " .. readableName .. ".", duration=2, buttons=false, code=106, dialogueTree="no", unit=pokemonAvatar:entindex()})	
		pokemonAvatar.trainer.state = "LearningNewMove"
	else
		Notifications:RPGTextBox(player, {text=pokemon:GetName() .. " learned " .. readableName .. "!", duration=2, buttons=false, code=107, dialogueTree=""})
	end
end

function GameMode:DeleteAbility( args )
	local playerID = args['player_id']
	local abilityName = args['ability_to_delete']
	local player = PlayerResource:GetPlayer(playerID)
	local trainer = player:GetAssignedHero()
	local pokemonAvatar = trainer.pokemonAvatar
	local pokemon = trainer.pokemonAvatar.pokemon

	pokemon:RemoveAbility(abilityName)
	pokemonAvatar:RemoveAbility(abilityName)
	PokeHelper:EndBattleState( trainer )
	CustomGameEventManager:Send_ServerToPlayer(player, "go_to_next_text_box", {})
end

function GameMode:UpdatePartyPanelResponse( args )
	local playerID = args['player_id']
	local player = PlayerResource:GetPlayer(playerID)
	local trainer = player:GetAssignedHero()
	
	CustomGameEventManager:Send_ServerToPlayer(player, "update_party_panel_response", PokeHelper:GetPartyData( trainer ) )
end

function GameMode:TriggerNPCText( args )
	local playerID = args['player_id']
	local selectedUnit = EntIndexToHScript(args['unit_entindex'])
	local ability = selectedUnit:FindAbilityByName("npc_dialogue")
	
	selectedUnit.playerID = playerID
	selectedUnit:CastAbilityNoTarget(ability, -1)
end

function GameMode:ExecuteOrderFilter( order )
	if order.order_type >=5 and order.order_type < 10 then
		local units = order.units
		local caster
		if units["0"] then
	    	caster = EntIndexToHScript(units["0"])
	    end
		
		if caster:FindModifierByName("modifier_confusion") then
			print(caster.pokemon:GetName() .. " is confused!")

			if caster.confusionCounter == nil then
				print("Confusion not properly initialized")
			end

			caster.confusionCounter = caster.confusionCounter - 1

			if caster.confusionCounter < 0 then
				caster:RemoveModifierByName("modifier_confusion")
				print(caster.pokemon:GetName() .. " is no longer confused!")
			elseif RandomFloat(0,1) < .5 then
				print("Hurt itself in confusion!")
				PokeHelper:CalculatePokemonDamage( nil, caster, caster, "NO_TYPE", 40, DAMAGE_TYPE_PHYSICAL )
				return false
			end
		end
	end
	return true
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
  
  GameRules.APPLIER = CreateItem("item_apply_modifiers", nil, nil)
  
  -- custom listeners from panorama are here
  CustomGameEventManager:RegisterListener( "delete_ability", Dynamic_Wrap(GameMode, "DeleteAbility") )
  CustomGameEventManager:RegisterListener( "update_party_panel_request", Dynamic_Wrap(GameMode, "UpdatePartyPanelResponse") )
  CustomGameEventManager:RegisterListener( "talkable_npc_selected", Dynamic_Wrap(GameMode, "TriggerNPCText") )

  GameRules:GetGameModeEntity():SetExecuteOrderFilter(Dynamic_Wrap(GameMode, "ExecuteOrderFilter"), self)

  DebugPrint('[BAREBONES] Done loading Barebones gamemode!\n\n')
end