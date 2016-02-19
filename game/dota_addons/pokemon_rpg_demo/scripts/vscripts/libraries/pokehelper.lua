if PokeHelper == nil then
  PokeHelper = class({})
end

--calculates AND DEALS damage between an attacking and defending pokemon, from an ability
function PokeHelper:CalculatePokemonDamage( ability, attacker, target, damageType )
	--both attacker and target are pokemon avatars
	local attackingPokemon = attacker.pokemon
	local defendingPokemon = target.pokemon
	--don't do anything to a unit that is not a pokemon
	if defendingPokemon ~= nil then
		local attackerType1 = attackingPokemon:GetType1()
		local attackerType2 = attackingPokemon:GetType2()
		local defenderType1 = defendingPokemon:GetType1()
		local defenderType2 = defendingPokemon:GetType2()
		local baseDamage = ability:GetLevelSpecialValueFor("base_damage", (ability:GetLevel() - 1))
		local damageCategory = ability:GetAbilityDamageType()
		
		local multiplier = 1 * RandomFloat(.85,1)
		local damage = 0
		
		if attackerType1 == damageType or attackerType2 == damageType then
			multiplier = multiplier * 1.5
		end
		
		local typeMultiplier = 1
		typeMultiplier = typeMultiplier * PokeHelper:TypeMatchUp(damageType, defenderType1)
		if defenderType2 ~= nil then
			typeMultiplier = typeMultiplier * PokeHelper:TypeMatchUp(damageType, defenderType2)
		end
		
		multiplier = multiplier * typeMultiplier
		
		--damageCategory is physical, magical or pure, relates to physical, special or pure
		if damageCategory == DAMAGE_TYPE_PHYSICAL then
			damage = ((((2 * attackingPokemon:GetLevel() + 10) / 250) * (attackingPokemon:GetAttack() / defendingPokemon:GetDefense()) * baseDamage) + 2 ) * multiplier
		elseif damageCategory == DAMAGE_TYPE_MAGICAL then
			damage = ((((2 * attackingPokemon:GetLevel() + 10) / 250) * (attackingPokemon:GetSpecialAttack() / defendingPokemon:GetSpecialDefense()) * baseDamage) + 2 ) * multiplier
		elseif damageCategory == DAMAGE_TYPE_PURE then
			damage = baseDamage
			if multiplier == 0 then
				damage = 0
			end
		end
		
		if typeMultiplier > 1 then
			target:AddSpeechBubble(1, "It's super effective!", 1, 0, 0)
		elseif typeMultiplier < 1 and typeMultiplier > 0 then
			target:AddSpeechBubble(1, "It's not very effective...", 1, 0, 0)
		elseif typeMultiplier == 0 then
			target:AddSpeechBubble(1, "It doesn't affect " .. defendingPokemon:GetName() .. ".", 1, 0, 0)
		end
		
		PokeHelper:AddKillCredit(target, attackingPokemon)

		return PokeHelper:DealDamage( target, damage, attacker )
	end
end

--record that the attacker did damage to the target, to show that it was involved in the battle

function PokeHelper:AddKillCredit(target, attackingPokemon)
	if target.attackers == nil then
		target.attackers = {}
		target.numAttackers = 0
	end
	--if this attacker hasn't attacked this target before
	if target.attackers[attackingPokemon] == nil then
		target.numAttackers = target.numAttackers + 1
	end
	target.attackers[attackingPokemon] = true
end

--deals the exact amount of damage, regardless of type/stats
function PokeHelper:DealDamage( target, damage, attacker )
	defendingPokemon = target.pokemon
	
	damage = math.ceil(damage) --only deal damage in whole numbers
	
	local damage_table = {}

	if attacker ~= nil then
		damage_table.attacker = attacker
	else
		print("dealing damage without attacker")
	end
	damage_table.damage_type = DAMAGE_TYPE_PURE
	--damage_table.ability = ability
	damage_table.victim = target
	damage_table.damage = damage

	defendingPokemon:SetCurrentHP(defendingPokemon:GetCurrentHP() - damage)
	ApplyDamage(damage_table)
	
	--send an update to the client of the pokemon's current HP
	--but only if it didn't kill
	if target.trainer ~= nil and defendingPokemon:GetCurrentHP() > 0 then
		local healthData = {
			health = defendingPokemon:GetCurrentHP(),
			maxHealth = defendingPokemon:GetMaxHP()
		}
		CustomGameEventManager:Send_ServerToPlayer(target.trainer:GetPlayerOwner(), "update_health", healthData )
	end
	
	--make sure we use the metadata HP for the pokemon's health
	if target:IsAlive() then
		target:SetHealth(defendingPokemon:GetCurrentHP())
		if defendingPokemon:GetCurrentHP() <= 0 then
			target:AddNoDraw()
			target:ForceKill( false )
		end
	else
		defendingPokemon:SetCurrentHP(0)
	end
	
	return damage
end

--returns the multiplier based on the type chart
function PokeHelper:TypeMatchUp( attackType, defendType )
	if attackType == "NORMAL" then
		if defendType == "ROCK" or defendType == "STEEL" then
			return .5
		elseif defendType == "GHOST" then
			return 0
		end
	elseif attackType == "FIGHTING" then
		if defendType == "NORMAL" or defendType == "ROCK" or defendType == "STEEL" or defendType == "ICE" or defendType == "DARK" then
			return 2
		elseif defendType == "FLYING" or defendType == "POISON" or defendType == "PSYCHIC" or defendType == "FAIRY" then
			return .5
		elseif defendType == "GHOST" then
			return 0
		end
	elseif attackType == "FLYING" then
		if defendType == "FIGHTING" or defendType == "BUG" or defendType == "GRASS" then
			return 2
		elseif defendType == "ROCK" or defendType == "STEEL" or defendType == "ELECTRIC" then
			return .5
		end
	elseif attackType == "POISON" then
		if defendType == "GRASS" or defendType == "FAIRY" then
			return 2
		elseif defendType == "POISON" or defendType == "GROUND" or defendType == "ROCK" or defendType == "GHOST" then
			return .5
		elseif defendType == "STEEL" then
			return 0
		end
	elseif attackType == "GROUND" then
		if defendType == "POISON" or defendType == "ROCK" or defendType == "STEEL" or defendType == "FIRE" or defendType == "ELECTRIC" then
			return 2
		elseif defendType == "BUG" or defendType == "GRASS" then
			return .5
		elseif defendType == "FLYING" then
			return 0
		end
	elseif attackType == "ROCK" then
		if defendType == "FLYING" or defendType == "BUG" or defendType == "FIRE" or defendType == "ICE" then
			return 2
		elseif defendType == "FIGHTING" or defendType == "GROUND" or defendType == "STEEL" then
			return .5
		end
	elseif attackType == "BUG" then
		if defendType == "GRASS" or defendType == "PSYCHIC" or defendType == "DARK" then
			return 2
		elseif defendType == "FIGHTING" or defendType == "FLYING" or defendType == "POISON" or defendType == "GHOST" or defendType == "STEEL" or defendType == "FIRE" or defendType == "FAIRY" then
			return .5
		elseif defendType == "GHOST" then
			return 0
		end
	elseif attackType == "GHOST" then
		if defendType == "GHOST" or defendType == "PSYCHIC" then
			return 2
		elseif defendType == "DARK" then
			return .5
		elseif defendType == "NORMAL" then
			return 0
		end
	elseif attackType == "STEEL" then
		if defendType == "ROCK" or defendType == "ICE" or defendType == "FAIRY" then
			return 2
		elseif defendType == "STEEL" or defendType == "FIRE" or defendType == "WATER" or defendType == "ELECTRIC" then
			return .5
		end
	elseif attackType == "FIRE" then
		if defendType == "BUG" or defendType == "STEEL" or defendType == "GRASS" or defendType == "ICE" then
			return 2
		elseif defendType == "ROCK" or defendType == "FIRE" or defendType == "WATER" or defendType == "DRAGON"then
			return .5
		end
	elseif attackType == "WATER" then
		if defendType == "GROUND" or defendType == "ROCK"  or defendType == "FIRE" then
			return 2
		elseif defendType == "WATER" or defendType == "GRASS" or defendType == "DRAGON" then
			return .5
		end
	elseif attackType == "GRASS" then
		if defendType == "GROUND" or defendType == "ROCK" or defendType == "WATER" then
			return 2
		elseif defendType == "FLYING" or defendType == "POISON" or defendType == "BUG" or defendType == "STEEL" or defendType == "FIRE" or defendType == "DRAGON" then
			return .5
		end
	elseif attackType == "ELECTRIC" then
		if defendType == "FLYING" or defendType == "WATER" then
			return 2
		elseif defendType == "GRASS" or defendType == "ELECTRIC" or defendType == "DRAGON" then
			return .5
		elseif defendType == "GROUND" then
			return 0
		end
	elseif attackType == "PSYCHIC" then
		if defendType == "FIGHTING" or defendType == "POISON" then
			return 2
		elseif defendType == "STEEL" or defendType == "PSYCHIC" then
			return .5
		elseif defendType == "DARK" then
			return 0
		end
	elseif attackType == "ICE" then
		if defendType == "FLYING" or defendType == "GROUND" or defendType == "GRASS" or defendType == "DRAGON" then
			return 2
		elseif defendType == "STEEL" or defendType == "FIRE" or defendType == "WATER" or defendType == "ICE" then
			return .5
		end
	elseif attackType == "DRAGON" then
		if defendType == "DRAGON" then
			return 2
		elseif defendType == "STEEL" then
			return .5
		elseif defendType == "FAIRY" then
			return 0
		end
	elseif attackType == "DARK" then
		if defendType == "GHOST" or defendType == "PSYCHIC" then
			return 2
		elseif defendType == "FIGHTING" or defendType == "DARK" or defendType == "FAIRY" then
			return .5
		end
	elseif attackType == "FAIRY" then
		if defendType == "FIGHTING" or defendType == "DRAGON" or defendType == "DARK" then
			return 2
		elseif defendType == "POISON" or defendType == "STEEL" or defendType == "FIRE" then
			return .5
		end
	end
	return 1
end

--creates a pokemon object using KV metadata
function PokeHelper:CreatePokemonFromMetadata( metadata, level, isWild, abilityList)
	local experience = level ^ 3
	local p = metadata --shortened to make the initializer shorter
	local abilityList = abilityList or {}
	--if they didn't provide an ability list, generate abilities for it
	if #abilityList == 0 then
		for k,v in pairs( p.learnSet ) do
			if tonumber(k) < level then
				table.insert(abilityList,1,v)
				if #abilityList > 4 then
					table.remove(abilityList)
				end
			end
		end
	end
	
	return Pokemon.new( string.upper(p.unitName), p.unitName, p.type1, p.type2, p.baseAttack, p.baseDefense, p.baseSpecialAttack, p.baseSpecialDefense, p.baseSpeed, p.baseHP, p.expYield, p.catchRate, experience, abilityList, isWild )
end

--creates an in game unit from a pokemon object at a location
function PokeHelper:CreatePokemonAtPosition( pokemon, position, owner, team )
	--if the owner/team is nil, then it's a wild pokemon
	local owner = owner or nil
	local team = team or DOTA_TEAM_NEUTRALS
	local player = nil
	
	if owner ~= nil then
		player = owner:GetPlayerOwner()
	end
	
	--make sure their buff levels are cleared
	pokemon:ClearBuffLevels()
	
	--create the avatar, the physicial in game unit
	local pokemonAvatar = CreateUnitByName(pokemon:GetUnitName(), position, true, player, owner, team)
	if owner ~= nil then
		pokemonAvatar:SetControllableByPlayer(owner:GetPlayerID(), true)
		owner.pokemonAvatar = pokemonAvatar
		local statsData = 
		{
			name = pokemon:GetName(),
			level = pokemon:GetLevel(),
			health = pokemon:GetCurrentHP(),
			maxHealth = pokemon:GetMaxHP(),
			attack = pokemon:GetAttack(),
			defense = pokemon:GetDefense(),
			spAttack = pokemon:GetSpecialAttack(),
			spDefense = pokemon:GetSpecialDefense(),
			speed = pokemon:GetSpeed(),
			experience = pokemon:GetExperience(),
			toNextLevel = pokemon:GetExpToNextLevel()
		}
		CustomGameEventManager:Send_ServerToPlayer(player, "create_pokemon", statsData )
	end
	--assign the pokemon metadata to the avatar
	pokemonAvatar.pokemon = pokemon
	pokemonAvatar.trainer = owner
	--adjust the avatar's stats
	pokemonAvatar:CreatureLevelUp(pokemon:GetLevel())
	pokemonAvatar:SetMaxHealth(pokemon:GetMaxHP())
	pokemonAvatar:SetBaseMaxHealth(pokemon:GetMaxHP())
	pokemonAvatar:SetHealth(pokemon:GetCurrentHP())
	--pokemonAvatar:SetBaseMoveSpeed(pokemon:GetSpeed())
	--pokemon are silenced for 3 seconds whenever they use an ability
	PokeHelper:ApplyModifier( pokemonAvatar, "modifier_silence_after_spell" )
	--give the avatar its abilities
	for _,v in ipairs(pokemon:GetAbilityList()) do
		pokemonAvatar:AddAbility(v)
		local ability = pokemonAvatar:FindAbilityByName(v)
		ability:UpgradeAbility(true)
	end
	--if the pokemon is afflicted by a status, apply the relevant modifier
	local status = pokemon:GetStatus()
	PokeHelper:InflictStatus( pokemonAvatar, status )
	
	return pokemonAvatar
end

--withdraws the current pokemon
function PokeHelper:Withdraw( trainer )
	CustomGameEventManager:Send_ServerToPlayer(trainer:GetPlayerOwner(), "withdraw_pokemon", {} )
	--currentHP stays the same, but clear all other stat modifiers
	local pokemonAvatar = trainer.pokemonAvatar
	if pokemonAvatar ~= nil then 
		local pokemon = pokemonAvatar.pokemon
		pokemon:SetCurrentHP(pokemonAvatar:GetHealth())
		pokemon:ClearBuffLevels()
		pokemonAvatar:AddNoDraw()
		pokemonAvatar:ForceKill( false )
		trainer.pokemonAvatar = nil
	end
end

--calculates how much experience this pokemon gives upon defeate
function PokeHelper:CalculateExp( victoriousPokemon, defeatedPokemon )
	local a = 1.5
	if defeatedPokemon:IsWild() then
		a = 1
	end
	local b = defeatedPokemon:GetExpYield()
	local l = defeatedPokemon:GetLevel()
	local lp = victoriousPokemon:GetLevel()
	return (((a*b*l) / 5) * (((2*l+10)^2.5) / (l+lp+10)^2.5) + 1)
end

function PokeHelper:InflictStatus( pokemonAvatar, status )
	--make sure to update the Pokemon status
	pokemonAvatar.pokemon:InflictStatus(status)
	if status == "NORMAL" then
		--do nothing
	elseif status == "BURNED" then
		PokeHelper:ApplyModifier( pokemonAvatar, "modifier_burned" )
	elseif status == "PARALYZED" then
		PokeHelper:ApplyModifier( pokemonAvatar, "modifier_paralysis" )
	elseif status == "FROZEN" then
		PokeHelper:ApplyModifier( pokemonAvatar, "modifier_frozen" )
	elseif status == "SLEEP" then
		PokeHelper:ApplyModifier( pokemonAvatar, "modifier_sleep" )
	elseif status == "POISONED" then
		PokeHelper:ApplyModifier( pokemonAvatar, "modifier_poisoned" )
	else
		print("Invalid Status Name: " .. status)
	end
end

function PokeHelper:GetNextUseablePokemon( trainer )
	local item
	
	for i=0,5 do
		if trainer:GetItemInSlot(i) ~= nil then
			item = trainer:GetItemInSlot(i)
			local pokemon = item.pokemon
			if pokemon ~= nil and pokemon:GetCurrentHP() > 0 then
				return pokemon
			end
		end
	end
	
	return nil
end

function PokeHelper:StartBattle( trainer )
	trainer.state = "Battle"
	trainer:AddNewModifier(trainer,nil,"modifier_rooted",{})
	trainer:AddNewModifier(trainer,nil,"modifier_invulnerable",{})
	--send out the first pokemon in your inventory
	local pokemon = PokeHelper:GetNextUseablePokemon( trainer )
	if pokemon ~= nil then
		local position = trainer:GetAbsOrigin() + RandomVector( RandomFloat( 200, 300 ) )
		local pokemonAvatar = PokeHelper:CreatePokemonAtPosition( pokemon, position, trainer, trainer:GetTeam() )
		Selection:NewSelection( pokemonAvatar )
	else
		print("ERROR: Tried to start a battle with no useable pokemon. This should not be possible")
		PokeHelper:EndBattleState( trainer )
	end
end

function PokeHelper:EndBattleState( trainer )
	trainer.state = "Normal"
	trainer:RemoveModifierByName("modifier_rooted")
	trainer:RemoveModifierByName("modifier_invulnerable")
	Selection:NewSelection( trainer )
	PokeHelper:Withdraw( trainer )
	
	CustomGameEventManager:Send_ServerToPlayer(trainer:GetPlayerOwner(), "battle_ended", PokeHelper:GetPartyData( trainer ) )
end

function PokeHelper:GetPartyData( trainer )
	--wow this code is ugly, but it works
	--could pretty easily redo it using arrays
	local item
	local name1 = ""
	local name2 = ""
	local name3 = ""
	local name4 = ""
	local name5 = ""
	local name6 = ""		
	local health1 = ""
	local level1 = ""
	local health2 = ""
	local level2 = ""
	local health3 = ""
	local level3 = ""
	local health4 = ""
	local level4 = ""
	local health5 = ""
	local level5 = ""
	local health6 = ""
	local level6 = ""
	local maxHealth1 = ""
	local maxHealth2 = ""
	local maxHealth3 = ""
	local maxHealth4 = ""
	local maxHealth5 = ""
	local maxHealth6 = ""

	if trainer:GetItemInSlot(0) ~= nil then
		item = trainer:GetItemInSlot(0)
		local pokemon = item.pokemon
		if pokemon ~= nil then
			name1 = pokemon:GetName()
			health1 = pokemon:GetCurrentHP()
			maxHealth1 = pokemon:GetMaxHP()
			level1 = pokemon:GetLevel()
		end		
	end
	if trainer:GetItemInSlot(1) ~= nil then
		item = trainer:GetItemInSlot(1)
		local pokemon = item.pokemon
		if pokemon ~= nil then
			name2 = pokemon:GetName()
			health2 = pokemon:GetCurrentHP()
			maxHealth2 = pokemon:GetMaxHP()
			level2 = pokemon:GetLevel()
		end		
	end
	if trainer:GetItemInSlot(2) ~= nil then
		item = trainer:GetItemInSlot(2)
		local pokemon = item.pokemon
		if pokemon ~= nil then
			name3 = pokemon:GetName()
			health3 = pokemon:GetCurrentHP()
			maxHealth3 = pokemon:GetMaxHP()
			level3 = pokemon:GetLevel()
		end		
	end
	if trainer:GetItemInSlot(3) ~= nil then
		item = trainer:GetItemInSlot(3)
		local pokemon = item.pokemon
		if pokemon ~= nil then
			name4 = pokemon:GetName()
			health4 = pokemon:GetCurrentHP()
			maxHealth4 = pokemon:GetMaxHP()
			level4 = pokemon:GetLevel()
		end		
	end
	if trainer:GetItemInSlot(4) ~= nil then
		item = trainer:GetItemInSlot(4)
		local pokemon = item.pokemon
		if pokemon ~= nil then
			name5 = pokemon:GetName()
			health5 = pokemon:GetCurrentHP()
			maxHealth5 = pokemon:GetMaxHP()
			level5 = pokemon:GetLevel()
		end		
	end
	if trainer:GetItemInSlot(5) ~= nil then
		item = trainer:GetItemInSlot(5)
		local pokemon = item.pokemon
		if pokemon ~= nil then
			name6 = pokemon:GetName()
			health6 = pokemon:GetCurrentHP()
			maxHealth6 = pokemon:GetMaxHP()
			level6 = pokemon:GetLevel()
		end		
	end
	
	local partyData = {
		name1 = name1,
		name2 = name2,
		name3 = name3,
		name4 = name4,
		name5 = name5,
		name6 = name6,		
		health1 = health1,
		level1 = level1,
		health2 = health2,
		level2 = level2,
		health3 = health3,
		level3 = level3,
		health4 = health4,
		level4 = level4,
		health5 = health5,
		level5 = level5,
		health6 = health6,
		level6 = level6,
		maxHealth1 = maxHealth1,
		maxHealth2 = maxHealth2,
		maxHealth3 = maxHealth3,
		maxHealth4 = maxHealth4,
		maxHealth5 = maxHealth5,
		maxHealth6 = maxHealth6
	}
	
	return partyData
end

--[[
function PokeHelper:GetPartyData( trainer )
    local partyData = {}

    for i=0,5 do
        local item = trainer:GetItemInSlot(i)
        partyData[i] = {}
        if item and item.pokemon then
            local pokemon = item.pokemon
            partyData[i].name = pokemon:GetName()
            partyData[i].health = pokemon:GetCurrentHP()
            partyData[i].maxHealth = pokemon:GetMaxHP()
            partyData[i].level = pokemon:GetLevel()
        else
    end
    
    return partyData
end
]]

function PokeHelper:WipeOut( trainer )
	local teleportLocation = Entities:FindByName( nil, "pokemon_center_teleport" ):GetAbsOrigin()
	FindClearSpaceForUnit(trainer, teleportLocation, false)
	trainer:Stop()
	
	PokeHelper:EndBattleState( trainer )
	
	--move the camera to where the player warped
	PlayerResource:SetCameraTarget(trainer:GetPlayerID(), trainer)
	Timers:CreateTimer(0.1, function()
		PlayerResource:SetCameraTarget(trainer:GetPlayerID(), nil)
		--heal pokemon
		--this is in the timer, because it doesn't seem to be working
		for i=0,5 do
			if trainer:GetItemInSlot(i) ~= nil then
				local item = trainer:GetItemInSlot(i)
				local pokemon = item.pokemon
				if pokemon ~= nil then
					pokemon:ClearStatus()
					pokemon:SetCurrentHP(pokemon:GetMaxHP())
				end
			end
		end
		CustomGameEventManager:Send_ServerToPlayer(trainer:GetPlayerOwner(), "update_health", {} )
	end)
	
	Notifications:RPGTextBox(trainer:GetPlayerID(), {text="You blacked out...", duration=3, buttons=false, code=200, dialogueTree=""})
end

------------------------------------------------
--               Global item applier          -- thanks Noya for this
------------------------------------------------
function PokeHelper:ApplyModifier( unit, modifier_name )
    GameRules.APPLIER:ApplyDataDrivenModifier(unit, unit, modifier_name, {})
end
