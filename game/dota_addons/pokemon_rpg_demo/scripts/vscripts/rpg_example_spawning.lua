unit_tables_roam = require( "unit_tables_roam" )

--------------------------------------------------------------------------------
-- SetupSpawners
--------------------------------------------------------------------------------
function GameMode:SetupSpawners()
	self.tSPAWNERS_ALL = {}
	for name, unitTable in pairs( unit_tables_roam ) do
		for _, hSpawner in pairs( Entities:FindAllByName( name ) ) do
			hSpawner.unitTable = unitTable
			--make a timer for this spawner that will constantly search to see if there is a nearby trainer
			Timers:CreateTimer(0,
				function()
					--see if there is a trainer nearby, and if there is, chance to spawn a pokemon
					local searchRadius = 1000
					local spawnChance = .1
					
					local foundTrainers = FindUnitsInRadius(DOTA_TEAM_NEUTRALS, hSpawner:GetAbsOrigin(), nil, searchRadius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, 0, 0, false)
					for _,trainer in pairs(foundTrainers) do
						--if the trainer is not already in battle, there's a chance to spawn a pokemon
						if trainer.state == "Normal" then
							if RandomFloat(0,1) < spawnChance then
								PokeHelper:StartBattle( trainer )
								GameMode:SpawnPokemon( trainer, hSpawner )
							end
						end
					end
					
					return RandomFloat( 1, 1.5 )
				end)
		end
	end
end

--------------------------------------------------------------------------------
-- SpawnPokemon
--------------------------------------------------------------------------------
function GameMode:SpawnPokemon( trainer, hSpawner )
	local unitTable = hSpawner.unitTable
	local nMaxDistanceFromSpawner = 600
	--select a random unit for the units table, weighted using cumulative sum
	local unit = GetRandomWeightedElement(unitTable)
	local metadata = self.pokemon_table[unit.name]
	local level = RandomInt(unit.minLevel,unit.maxLevel)
	local pokemon = PokeHelper:CreatePokemonFromMetadata(metadata, level, true)
	
	local vSpawnLoc = nil
	while vSpawnLoc == nil do
		vSpawnLoc = hSpawner:GetOrigin() + RandomVector( RandomFloat( 0, nMaxDistanceFromSpawner ) )
	    if ( GridNav:CanFindPath( hSpawner:GetOrigin(), vSpawnLoc ) == false ) then
	        print( "Choosing new unit spawnloc.  Bad spawnloc was: " .. tostring( vSpawnLoc ) )
	        vSpawnLoc = nil
	    end
	end
	
	local pokemonAvatar = PokeHelper:CreatePokemonAtPosition( pokemon, vSpawnLoc )
	pokemonAvatar.hSpawner = hSpawner
	pokemonAvatar.trainerTable = trainer
	Notifications:RPGTextBox(trainer:GetPlayerID(), {text="A wild " .. pokemon:GetName() .. " appeared!", duration=2, buttons=false, code=0, dialogueTree=""})
end

---------------------------------------------------------------------------
-- GetRandomWeightedElement (from cumulative sum table)
---------------------------------------------------------------------------
function GetRandomWeightedElement( table )
	local randomInt = RandomInt( 0, 99 )
	for i=1,#table do
		tableValue = table[i]
		if randomInt < tableValue.cSumSpawnRate then
			return tableValue
		end
	end
end