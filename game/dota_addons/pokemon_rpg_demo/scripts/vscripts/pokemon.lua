Pokemon = {} -- the table representing the class, which will double as the metatable for the instances
Pokemon.__index = Pokemon -- failed table lookups on the instances should fallback to the class table, to get methods

function Pokemon.new(name, unitName, type1, type2, baseAttack, baseDefense, baseSpecialAttack, baseSpecialDefense, baseSpeed, baseHP, baseExpYield, catchRate, totalExperience, abilityList, isWild)
	local self = setmetatable({}, Pokemon)

	self.name = name
	self.unitName = unitName
	self.type1 = type1
	self.type2 = type2
	self.baseExpYield = baseExpYield
	self.catchRate = catchRate
	self.status = "NORMAL"
	
	self.totalExperience = totalExperience
	self.level = math.floor(self.totalExperience ^ (1/3))

	self.baseAttack = baseAttack
	self.baseDefense = baseDefense
	self.baseSpecialAttack = baseSpecialAttack
	self.baseSpecialDefense = baseSpecialDefense
	self.baseSpeed = baseSpeed
	self.baseHP = baseHP

	self.attackBuffLevel = 0
	self.defenseBuffLevel = 0
	self.specialAttackBuffLevel = 0
	self.specialDefenseBuffLevel = 0
	self.speedBuffLevel = 0

	self.currentHP = (((baseHP * self.level) + 50) / 50) + 10
	
	self.isWild = isWild or true
	
	self.abilityList = abilityList or {}

	return self
end

--new pokemon has new stats, but retains the same name, abilities and experience
function Pokemon:Evolve(unitName, type1, type2, baseAttack, baseDefense, baseSpecialAttack, baseSpecialDefense, baseSpeed, baseHP, baseExpYield, catchRate)
	self.unitName = unitName
	self.type1 = type1
	self.type2 = type2
	self.baseExpYield = baseExpYield
	self.catchRate = catchRate
	self.baseAttack = baseAttack
	self.baseDefense = baseDefense
	self.baseSpecialAttack = baseSpecialAttack
	self.baseSpecialDefense = baseSpecialDefense
	self.baseSpeed = baseSpeed
	self.baseHP = baseHP
	self.currentHP = (((baseHP * level) + 50) / 50) + 10
end

function Pokemon:GetAttack()
	local statusMod = 1
	if self.status == "BURNED" then
		statusMod = .5
	end
	return (((self.baseAttack * self.level) / 50) + 5) * Pokemon:BuffLevelToPercent(self.attackBuffLevel) * statusMod
end

function Pokemon:GetDefense()
	return (((self.baseAttack * self.level) / 50) + 5) * Pokemon:BuffLevelToPercent(self.defenseBuffLevel)
end

function Pokemon:GetSpecialAttack()
	return (((self.baseAttack * self.level) / 50) + 5) * Pokemon:BuffLevelToPercent(self.specialAttackBuffLevel)
end

function Pokemon:GetSpecialDefense()
	return (((self.baseAttack * self.level) / 50) + 5) * Pokemon:BuffLevelToPercent(self.specialDefenseBuffLevel)
end

function Pokemon:GetSpeed()
	local statusMod = 1
	if self.status == "PARALYZED" then
		statusMod = .5
	end
	return (((self.baseAttack * self.level) / 50) + 5) * Pokemon:BuffLevelToPercent(self.speedBuffLevel) * statusMod
end

function Pokemon:GetMaxHP()
	return (((self.baseHP * self.level) + 50) / 50) + 10
end

function Pokemon:BuffLevelToPercent( buffLevel )
	if buffLevel >= 0 then
		return (buffLevel + 2) / 2
	else
		return 2 / (2 - buffLevel)
	end
end

function Pokemon:IncrementAttackBuffLevel( buffIncrement )
	self.attackBuffLevel = self.attackBuffLevel + buffIncrement
	self.attackBuffLevel = Pokemon:BuffLevelBinding( self.attackBuffLevel )
end

function Pokemon:IncrementDefenseBuffLevel( buffIncrement )
	self.defenseBuffLevel = self.defenseBuffLevel + buffIncrement
	self.defenseBuffLevel = Pokemon:BuffLevelBinding( self.defenseBuffLevel )
end

function Pokemon:IncrementSpecialAttackBuffLevel( buffIncrement )
	self.specialAttackBuffLevel = self.specialAttackBuffLevel + buffIncrement
	self.specialAttackBuffLevel = Pokemon:BuffLevelBinding( self.specialAttackBuffLevel )
end

function Pokemon:IncrementSpecialDefenseBuffLevel( buffIncrement )
	self.specialDefenseBuffLevel = self.specialDefenseBuffLevel + buffIncrement
	self.specialDefenseBuffLevel = Pokemon:BuffLevelBinding( self.specialDefenseBuffLevel )
end

function Pokemon:IncrementSpeedBuffLevel( buffIncrement )
	self.speedBuffLevel = self.speedBuffLevel + buffIncrement
	self.speedBuffLevel = Pokemon:BuffLevelBinding( self.speedBuffLevel )
end

function Pokemon:BuffLevelBinding( x )
	if x > 6 then
		return 6
	elseif x -6 then
		return -6
	else
		return x
	end
end

function Pokemon:ClearBuffLevels()
	self.attackBuffLevel = 0
	self.defenseBuffLevel = 0
	self.specialAttackBuffLevel = 0
	self.specialDefenseBuffLevel = 0
	self.speedBuffLevel = 0
end

function Pokemon:GetExperience()
	return self.totalExperience
end

function Pokemon:GetExpToNextLevel()
	return (self.level ^ 3) - self.totalExperience
end

--returns true if the pokemon gained a level
function Pokemon:AddExperience( experience )
	self.totalExperience = self.totalExperience + experience
	if math.floor(self.totalExperience ^ (1/3)) > self.level then
		self.level = math.floor(self.totalExperience ^ (1/3))
		return true
	end
end

function Pokemon:GetLevel()
	return self.level
end

function Pokemon:GetAbilityList()
	return self.abilityList
end

function Pokemon:AddAbility( newAbility )
	table.insert( self.abilityList, newAbility )
end

function Pokemon:RemoveAbility( abilityToRemove )
	for i,v in ipairs(self.abilityList) do
		if v == abilityToRemove then
			table.remove( self.abilityList, i )
			return
		end
	end
	print( abilityToRemove .. " not in Ability List." )
end

function Pokemon:GetCurrentHP()
	return self.currentHP
end

function Pokemon:SetCurrentHP( hp )
	if hp > ((((self.baseHP * self.level) + 50) / 50) + 10) then
		hp = ((((self.baseHP * self.level) + 50) / 50) + 10)
	elseif hp < 0 then
		hp = 0
	end
	self.currentHP = hp
end

function Pokemon:GetName()
	return self.name
end

function Pokemon:GetUnitName()
	return self.unitName
end

function Pokemon:GetType1()
	return self.type1
end

function Pokemon:GetType2()
	return self.type2
end

function Pokemon:IsWild()
	return self.isWild
end

function Pokemon:SetIsWild( isWild )
	self.isWild = isWild
end

function Pokemon:GetExpYield()
	return self.baseExpYield
end

function Pokemon:GetCatchRate()
	return self.catchRate
end

function Pokemon:GetStatus()
	return self.status
end

function Pokemon:InflictStatus( status )
	--status should be BURNED, PARALYZED, FROZEN, SLEEP, POISONED, NORMAL
	--status only changes when the current status is normal
	--steel types cannot be poisoned
	if status == "POISONED" then
		if self.type1 == "STEEL" or self.type2 == "STEEL" then
			print("Steel types cannot be poisoned")
			return
		end
	end
	if status == "NORMAL" then
		self.status = status
	end
end

function Pokemon:ClearStatus()
	self.status = "NORMAL"
end