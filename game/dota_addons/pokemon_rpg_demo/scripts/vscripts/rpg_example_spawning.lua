wild_pokemon_spawner_tables = require( "npc_tables/wild_pokemon_spawner_tables" )
trainer_spawner_tables = require( "npc_tables/trainer_spawner_tables" )
special_trainer_tables = require( "npc_tables/special_trainer_tables" )
npc_tables = require( "npc_tables/npc_tables" )


--------------------------------------------------------------------------------
-- SetupSpawners
--------------------------------------------------------------------------------
function GameMode:SetupSpawners()
	local searchRadius = 700
	local baseSpawnChance = 0.03221
	local currentSpawnChance = 0.03221

	--Wild Pokemon spawners
	for name, unitTable in pairs( wild_pokemon_spawner_tables ) do
		for _, hSpawner in pairs( Entities:FindAllByName( name ) ) do
			hSpawner.unitTable = unitTable
			--make a timer for this spawner that will constantly search to see if there is a nearby trainer
			--[[Timers:CreateTimer(5,
				function()
			local dummy = CreateUnitByName("npc_dummy_unit", hSpawner:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_NEUTRALS)
			local rangeParticle = ParticleManager:CreateParticle("particles/ui_mouseactions/range_display.vpcf", PATTACH_ABSORIGIN, dummy)
			    ParticleManager:SetParticleControl(rangeParticle, 0, dummy:GetAbsOrigin())
			    ParticleManager:SetParticleControl(rangeParticle, 1, Vector(searchRadius, 0, 0))
			    end)]]
			Timers:CreateTimer(0,
				function()
					--see if there is a trainer nearby, and if there is, chance to spawn a pokemon
					local foundTrainers = FindUnitsInRadius(DOTA_TEAM_NEUTRALS, hSpawner:GetAbsOrigin(), nil, searchRadius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, 0, 0, false)
					for _,trainer in pairs(foundTrainers) do
						--if the trainer is not already in battle, there's a chance to spawn a pokemon
						if trainer.state == "Normal" then
							currentSpawnChance = currentSpawnChance + baseSpawnChance
							if RandomFloat(0,1) < currentSpawnChance then
								currentSpawnChance = baseSpawnChance
								GameMode:StartWildPokemonBattle( trainer, hSpawner )
							end
						end
					end
					
					return RandomFloat( 1, 1.5 )
				end)
		end
	end

	--Trainer spawners
	for name,trainerBattleTable in pairs( trainer_spawner_tables ) do
		local spawnLocation = Entities:FindByName(nil, name):GetAbsOrigin()
		GameMode:InitializeAITrainer( trainerBattleTable, spawnLocation )		
	end

	--Talkable NPC spawners
	for name,npcTable in pairs( npc_tables ) do
		local spawnLocation = Entities:FindByName(nil, name):GetAbsOrigin()
		GameMode:InitializeNPC( npcTable.unit_name, npcTable.dialogue, spawnLocation )
	end
end

function GameMode:InitializeNPC( unitName, dialogueTable, spawnLocation)
	local npc = CreateUnitByName(unitName, spawnLocation, true, nil, nil, DOTA_TEAM_NEUTRALS)
	
	npc:SetAngles(0, RandomInt(0, 360), 0)
	npc.dialogueTable = dialogueTable
end

function GameMode:InitializeRivalBattles( starter )
	--these battles are different depending on your starter
	local numRivalBattles = 4
	local rival_battle_tables = special_trainer_tables[starter]

	for i=1,numRivalBattles do
		local spawnLocation = Entities:FindByName(nil, "rival" .. i):GetAbsOrigin()
		local trainerBattleTable = rival_battle_tables["rival" .. i]

		GameMode:InitializeAITrainer( trainerBattleTable, spawnLocation )
	end
end

function GameMode:InitializeAITrainer( trainerBattleTable, spawnLocation )
	local class = trainerBattleTable.class
	local pokemonTable = trainerBattleTable.pokemon
	local reward = trainerBattleTable.reward
	local preBattleTable = trainerBattleTable.preBattle
	local postBattleTable = trainerBattleTable.postBattle

	local enemyTrainer = CreateUnitByName(trainerBattleTable.class, spawnLocation, true, nil, nil, DOTA_TEAM_NEUTRALS)

	--turn the class into something human readable (bug_catcher -> Bug Catcher)
	class = class:gsub("_", " ")
	class = class:gsub("^%l", string.upper)

	enemyTrainer:SetAngles(0, RandomInt(0, 360), 0)
	enemyTrainer.postBattleTable = postBattleTable
	enemyTrainer.reward = reward
	enemyTrainer.name = class .. " " .. trainerBattleTable.name
	enemyTrainer:AddNewModifier(enemyTrainer,nil,"modifier_invulnerable",{})

	--give the trainer pokeballs for each of their pokemon
	for i=1,#pokemonTable do
		local name = pokemonTable[i].name
		local level = pokemonTable[i].level
		local abilityList = pokemonTable[i].abilityList
		local metadata = self.pokemon_table[name]
		local item = CreateItem("item_poke_ball", enemyTrainer, enemyTrainer)
		
		if abilityList == nil then
			item.pokemon = PokeHelper:CreatePokemonFromMetadata(metadata, level, false)
		else
			item.pokemon = PokeHelper:CreatePokemonFromMetadata(metadata, level, false, abilityList)
		end
		enemyTrainer:AddItem(item)
	end

	--see if there is a trainer nearby, and if there is, start the battle
	Timers:CreateTimer(0,
	function()
		if enemyTrainer.defeated == true then
			return
		end
		
		local foundTrainers = FindUnitsInRadius(DOTA_TEAM_NEUTRALS, spawnLocation, nil, 900, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, 0, 0, false)
		for _,trainer in pairs(foundTrainers) do
			if trainer:CanEntityBeSeenByMyTeam(enemyTrainer) == true then
				if trainer.state == "Normal" then
					PokeHelper:StartBattle( trainer )
					GameMode:StartTrainerBattle( trainer, trainerBattleTable, enemyTrainer )
				end
			end
		end
		
		return RandomFloat( .4, .6 )
	end)
end

--------------------------------------------------------------------------------
-- StartTrainerBattle
-- Begins a trainer battle with identified trainer. Battle continues until one
-- trainer runs out of useable pokemon.
--------------------------------------------------------------------------------
function GameMode:StartTrainerBattle( trainer, trainerBattleTable, enemyTrainer )
	local battleRadius = 900
	local pokemonTable = trainerBattleTable.pokemon
	local preBattleTable = trainerBattleTable.preBattle
	local postBattleTable = trainerBattleTable.postBattle
	local reward = trainerBattleTable.reward

	enemyTrainer:SetForwardVector((trainer:GetAbsOrigin() - enemyTrainer:GetAbsOrigin()):Normalized())
	
	local rangeParticle = ParticleManager:CreateParticle("particles/ui_mouseactions/range_display.vpcf", PATTACH_ABSORIGIN, enemyTrainer)
	    ParticleManager:SetParticleControl(rangeParticle, 0, enemyTrainer:GetAbsOrigin())
	    ParticleManager:SetParticleControl(rangeParticle, 1, Vector(battleRadius, 0, 0))

	enemyTrainer.target = trainer
	enemyTrainer.particle = rangeParticle

	Notifications:RPGTextBox(trainer:GetPlayerID(), {text=enemyTrainer.name .. " wants to battle!", duration=2, buttons=false, code=0, dialogueTree=""})
	for i=1,#preBattleTable do
		Notifications:RPGTextBox(trainer:GetPlayerID(), {text=preBattleTable[i], duration=2, buttons=false, code=0, dialogueTree=""})
	end

	PokeHelper:StartBattle( trainer )

	local fightDelay = 2+2*#preBattleTable

	Timers:CreateTimer(fightDelay,function()
		PokeHelper:SendOutNextPokemon( enemyTrainer )
		PokeHelper:SendOutNextPokemon( trainer )
	end)

end

--------------------------------------------------------------------------------
-- StartWildPokemonBattle
--------------------------------------------------------------------------------
function GameMode:StartWildPokemonBattle( trainer, hSpawner )
	local unitTable = hSpawner.unitTable
	local nMaxDistanceFromSpawner = 600
	local unit = GetRandomWeightedElement(unitTable)
	local metadata = self.pokemon_table[unit.name]
	local level = RandomInt(unit.minLevel,unit.maxLevel)
	local pokemon = PokeHelper:CreatePokemonFromMetadata(metadata, level, true)
	local vSpawnLoc = PokeHelper:FindSpaceWithinRange( hSpawner:GetOrigin(), 0, nMaxDistanceFromSpawner )

	local pokemonAvatar = PokeHelper:CreatePokemonAtPosition( pokemon, vSpawnLoc )
	pokemonAvatar.hSpawner = hSpawner
	pokemonAvatar.trainerTable = trainer

	PokeHelper:StartBattle( trainer )
	PokeHelper:SendOutNextPokemon( trainer )

	Notifications:RPGTextBox(trainer:GetPlayerID(), {text="A wild " .. pokemon:GetName() .. " appeared!", duration=2, buttons=false, code=0, dialogueTree=""})
end

---------------------------------------------------------------------------
-- GetRandomWeightedElement (from cumulative sum table)
-- select a random element from a table, weighted using cumulative sum
---------------------------------------------------------------------------
function GetRandomWeightedElement( table )
	local randomInt = RandomInt( 0, 99 )
	for i=1,#table do
		local tableValue = table[i]
		if randomInt < tableValue.cSumSpawnRate then
			return tableValue
		end
	end
end