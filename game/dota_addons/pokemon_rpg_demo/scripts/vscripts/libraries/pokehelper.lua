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
		
		multiplier = multiplier * PokeHelper:TypeMatchUp(damageType, defenderType1)
		if defenderType2 ~= nil then
			multiplier = multiplier * PokeHelper:TypeMatchUp(damageType, defenderType2)
		end
		
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
		
		--record that the attacker did damage to the target, to show that it was involved in the battle
		if target.attackers == nil then
			target.attackers = {}
			target.numAttackers = 0
		end
		--if this attacker hasn't attacked this target before
		if target.attackers[attackingPokemon] == nil then
			target.numAttackers = target.numAttackers + 1
		end
		target.attackers[attackingPokemon] = true

		local damage_table = {}

		damage_table.attacker = attacker
		damage_table.damage_type = DAMAGE_TYPE_PURE
		damage_table.ability = ability
		damage_table.victim = target
		damage_table.damage = damage

		defendingPokemon:SetCurrentHP(defendingPokemon:GetCurrentHP() - damage)
		ApplyDamage(damage_table)
		return damage
	end
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
function PokeHelper:CreatePokemonFromMetadata( metadata, level, abilityList )
	local experience = level ^ 3
	local p = metadata --shortened to make the initializer shorter
	local abilityList = abilityList or {}
	local isWild = false
	--if they didn't provide an ability list, it's a wild pokemon
	if #abilityList == 0 then
		for k,v in pairs( p.learnSet ) do
			if tonumber(k) < level then
				table.insert(abilityList,1,v)
				if #abilityList > 4 then
					table.remove(abilityList)
				end
			end
		end
		isWild = true
	end
	
	return Pokemon.new( string.upper(p.unitName), p.unitName, p.type1, p.type2, p.baseAttack, p.baseDefense, p.baseSpecialAttack, p.baseSpecialDefense, p.baseSpeed, p.baseHP, p.expYield, p.catchRate, experience, abilityList, isWild )
end

--creates an in game unit from a pokemon object at a location
function PokeHelper:CreatePokemonAtPosition( pokemon, position, owner, team )
	local owner = owner or nil
	local ownerOwner = nil
	if owner ~= nil then
		ownerOwner = owner:GetOwner()
	end
	local team = team or DOTA_TEAM_NEUTRALS
	--create the avatar, the physicial in game unit
	local pokemonAvatar = CreateUnitByName(pokemon:GetUnitName(), position, true, owner, ownerOwner, team)
	if owner ~= nil then
		pokemonAvatar:SetControllableByPlayer(owner:GetPlayerID(), true)
		owner.pokemonAvatar = pokemonAvatar
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
	--give the avatar its abilities
	for _,v in ipairs(pokemon:GetAbilityList()) do
		pokemonAvatar:AddAbility(v)
		pokemonAvatar:FindAbilityByName(v):UpgradeAbility(true)
	end
	return pokemonAvatar
end

--withdraws the current pokemon
function PokeHelper:Withdraw( trainer )
	--currentHP stays the same, but clear all other stat modifiers
	local pokemonAvatar = trainer.pokemonAvatar
	if pokemonAvatar ~= nil then 
		local pokemon = pokemonAvatar.pokemon
		pokemon:SetCurrentHP(pokemonAvatar:GetHealth())
		pokemon:ClearBuffLevels()
		--kill the avatar
		pokemonAvatar:ForceKill( false )
		trainer.pokemonAvatar = nil
	else
		print("There is no pokemon to withdraw")
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