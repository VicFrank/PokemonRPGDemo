--based on Leap from the spell library
--[[Leap Author: Pizzalol]]
--PP 35
--Power 50
--Accuracy 100%
--Type NORMAL
--Category Physical
function Tackle( keys )	
	local caster = keys.caster
	local ability = keys.ability
	local ability_level = ability:GetLevel() - 1	

	-- Clears any current command and disjoints projectiles
	caster:Stop()
	ProjectileManager:ProjectileDodge(caster)

	-- Ability variables
	ability.tackle_direction = caster:GetForwardVector()
	ability.tackle_distance = ability:GetLevelSpecialValueFor("tackle_distance", ability_level)
	ability.tackle_speed = ability:GetLevelSpecialValueFor("tackle_speed", ability_level) * 1/30
	ability.tackle_radius = ability:GetLevelSpecialValueFor("tackle_radius", (ability:GetLevel() - 1))
	ability.tackle_traveled = 0
	ability.tackle_z = 0
	
end

--[[Moves the caster on the horizontal axis until it has traveled the distance]]
function TackleHorizonal( keys )
	local caster = keys.target
	local ability = keys.ability
	local ground_position = GetGroundPosition(caster:GetAbsOrigin() , caster)

	if ability.tackle_traveled < ability.tackle_distance then
		local nextPosition = caster:GetAbsOrigin() + ability.tackle_direction * ability.tackle_speed
		--if we hit unpathable terrain, stop
		if not GridNav:IsTraversable(GetGroundPosition(nextPosition,caster)) or GridNav:IsBlocked(GetGroundPosition(nextPosition,caster)) then
			caster:InterruptMotionControllers(true)
			return nil
		end
		caster:SetAbsOrigin(nextPosition)
		ability.tackle_traveled = ability.tackle_traveled + ability.tackle_speed
	else
		caster:InterruptMotionControllers(true)
	end
	
	--check to see if we hit something
	local searchArea = FindUnitsInRadius( caster:GetTeam(), ground_position, nil, ability.tackle_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, 0, false )
	local target
	for _,v in pairs(searchArea) do
		target = v
	end
	if target ~= nil and target.pokemon ~= nil then
		caster:InterruptMotionControllers(true)
		EmitSoundOn("Hero_Slark.Pounce.Impact", target)
		PokeHelper:CalculatePokemonDamage(ability, caster, target, "NORMAL")
		return nil
	end
end

--[[Moves the caster on the vertical axis until movement is interrupted]]
function TackleVertical( keys )
	local caster = keys.target
	local ability = keys.ability

	-- For the first half of the distance the unit goes up and for the second half it goes down
	if ability.tackle_traveled < ability.tackle_distance/2 then
		-- Go up
		-- This is to memorize the z point when it comes to cliffs and such although the division of speed by 2 isnt necessary, its more of a cosmetic thing
		ability.tackle_z = ability.tackle_z + ability.tackle_speed/3
		-- Set the new location to the current ground location + the memorized z point
		caster:SetAbsOrigin(GetGroundPosition(caster:GetAbsOrigin(), caster) + Vector(0,0,ability.tackle_z))
	else
		-- Go down
		ability.tackle_z = ability.tackle_z - ability.tackle_speed/3
		caster:SetAbsOrigin(GetGroundPosition(caster:GetAbsOrigin(), caster) + Vector(0,0,ability.tackle_z))
	end
end