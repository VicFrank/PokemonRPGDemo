wild_pokemon_spawner_tables = require( "wild_pokemon_spawner_tables" )
trainer_spawner_tables = require( "trainer_spawner_tables" )

--------------------------------------------------------------------------------
-- SetupSpawners
--------------------------------------------------------------------------------
function GameMode:SetupSpawners()
	local searchRadius = 700
	local spawnChance = .15

	print(wild_pokemon_spawner_tables)
	print(trainer_spawner_tables)

	--Wild Pokemon spawners
	self.tSPAWNERS_ALL = {}
	for name, unitTable in pairs( wild_pokemon_spawner_tables ) do
		for _, hSpawner in pairs( Entities:FindAllByName( name ) ) do
			hSpawner.unitTable = unitTable
			--make a timer for this spawner that will constantly search to see if there is a nearby trainer
			rangeParticle = ParticleManager:CreateParticle("particles/ui_mouseactions/range_display.vpcf", PATTACH_CUSTOMORIGIN, nil)
		    ParticleManager:SetParticleControl(rangeParticle, 0, hSpawner:GetAbsOrigin())
		    ParticleManager:SetParticleControl(rangeParticle, 1, Vector(searchRadius, 0, 0))
			Timers:CreateTimer(0,
				function()
					--see if there is a trainer nearby, and if there is, chance to spawn a pokemon
					local foundTrainers = FindUnitsInRadius(DOTA_TEAM_NEUTRALS, hSpawner:GetAbsOrigin(), nil, searchRadius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, 0, 0, false)
					for _,trainer in pairs(foundTrainers) do
						--if the trainer is not already in battle, there's a chance to spawn a pokemon
						if trainer.state == "Normal" then
							if RandomFloat(0,1) < spawnChance then
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
		local testSpawner = trainerBattleTable.location
		local enemyTrainer = CreateUnitByName(trainerBattleTable.class, testSpawner, true, nil, nil, DOTA_TEAM_NEUTRALS)
		enemyTrainer:SetAngles(0, RandomInt(0, 360), 0)
		Timers:CreateTimer(0,
			function()
				if enemyTrainer.defeated == true then
					return
				end
				--see if there is a trainer nearby, and if there is, start the battle
				local foundTrainers = FindUnitsInRadius(DOTA_TEAM_NEUTRALS, testSpawner, nil, 900, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, 0, 0, false)
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
end

--------------------------------------------------------------------------------
-- StartTrainerBattle
-- Begins a trainer battle with identified trainer. Battle continues until one
-- trainer runs out of useable pokemon.
--------------------------------------------------------------------------------
function GameMode:StartTrainerBattle( trainer, trainerBattleTable, enemyTrainer )
	local battleRadius = 1000
	local class = trainerBattleTable.class
	local name = trainerBattleTable.name
	local pokemonTable = trainerBattleTable.pokemon
	local preBattleTable = trainerBattleTable.preBattle
	local postBattleTable = trainerBattleTable.postBattle
	local reward = trainerBattleTable.reward

	enemyTrainer:SetForwardVector((trainer:GetAbsOrigin() - enemyTrainer:GetAbsOrigin()):Normalized())
	
	rangeParticle = ParticleManager:CreateParticle("particles/ui_mouseactions/range_display.vpcf", PATTACH_ABSORIGIN, enemyTrainer)
	    ParticleManager:SetParticleControl(rangeParticle, 0, enemyTrainer:GetAbsOrigin())
	    ParticleManager:SetParticleControl(rangeParticle, 1, Vector(battleRadius, 0, 0))

	enemyTrainer.target = trainer
	enemyTrainer.particle = rangeParticle
	enemyTrainer.postBattleTable = postBattleTable
	enemyTrainer.reward = reward
	enemyTrainer.name = class .. " " .. name

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

	Notifications:RPGTextBox(trainer:GetPlayerID(), {text=class .. " " .. name .. " wants to battle!", duration=3, buttons=false, code=0, dialogueTree=""})
	for i=1,#preBattleTable do
		Notifications:RPGTextBox(trainer:GetPlayerID(), {text=preBattleTable[i], duration=2, buttons=false, code=0, dialogueTree=""})
	end

	PokeHelper:StartBattle( trainer )

	local fightDelay = 2+2*#preBattleTable

	Timers:CreateTimer(fightDelay,function()
		PokeHelper:SendOutFirstPokemon( enemyTrainer )
		PokeHelper:SendOutFirstPokemon( trainer )
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
	PokeHelper:SendOutFirstPokemon( trainer )

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