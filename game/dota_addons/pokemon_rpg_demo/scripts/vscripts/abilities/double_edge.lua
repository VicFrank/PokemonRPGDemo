--based on Leap from the spelllibrary
--[[Leap Author: Pizzalol]]
--PP 15
--Power 120
--Accuracy 100%
--Type NORMAL
--Category Physical
--user receives recoil damage equal to 1/3 of the damage done
function DoubleEdge( keys )
	local caster = keys.caster
	local ability = keys.ability
	local pokemon = caster.pokemon
	local distance = ability:GetLevelSpecialValueFor("distance", (ability:GetLevel() - 1))
	local speed = ability:GetLevelSpecialValueFor("speed", (ability:GetLevel() - 1))
	local radius = ability:GetLevelSpecialValueFor("radius", (ability:GetLevel() - 1))

	-- Clears any current command
	caster:Stop()

	-- Physics
	local direction = caster:GetForwardVector()
	local velocity = speed * 1.4
	local end_time = distance / speed
	local time_elapsed = 0
	local time = end_time/2
	local jump = end_time/0.5

	Physics:Unit(caster)

	caster:PreventDI(true)
	caster:SetAutoUnstuck(true)
	caster:SetNavCollisionType(PHYSICS_NAV_NOTHING)
	caster:FollowNavMesh(true)	
	caster:SetPhysicsVelocity(direction * velocity)


	-- Move the unit
	Timers:CreateTimer(0, function()
		local ground_position = GetGroundPosition(caster:GetAbsOrigin() , caster)
		time_elapsed = time_elapsed + 0.03
		if time_elapsed < time then
			caster:SetAbsOrigin(caster:GetAbsOrigin() + Vector(0,0,jump)) -- Going up
		else
			caster:SetAbsOrigin(caster:GetAbsOrigin() - Vector(0,0,jump)) -- Going down
		end
		--check to see if we hit something
		local searchArea = FindUnitsInRadius( caster:GetTeam(), ground_position, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, 0, false )
		local target
		for _,v in pairs(searchArea) do
			target = v
		end
		if target ~= nil and target.pokemon ~= nil then
			--caster hit its target, remove physics and normalize its position
			caster:SetAbsOrigin(Vector(caster:GetAbsOrigin().x,caster:GetAbsOrigin().y,129))
			caster:SetPhysicsAcceleration(Vector(0,0,0))
			caster:SetPhysicsVelocity(Vector(0,0,0))
			caster:OnPhysicsFrame(nil)
			caster:PreventDI(false)
			caster:SetNavCollisionType(PHYSICS_NAV_SLIDE)
			caster:SetAutoUnstuck(true)
			caster:FollowNavMesh(true)
			caster:SetPhysicsFriction(.05)
			local damage = PokeHelper:CalculatePokemonDamage(ability, caster, target, "NORMAL")
			--deal recoil damage
			damage = damage * (1/3)
			local damage_table = {}

			damage_table.attacker = caster
			damage_table.damage_type = DAMAGE_TYPE_PURE
			damage_table.ability = ability
			damage_table.victim = caster
			damage_table.damage = damage
			
			pokemon:SetCurrentHP(pokemon:GetCurrentHP() - damage)
			ApplyDamage(damage_table)
			return nil
		end
		-- If the target reached the ground then remove physics
		if caster:GetAbsOrigin().z - ground_position.z <= 0 then
			caster:SetPhysicsAcceleration(Vector(0,0,0))
			caster:SetPhysicsVelocity(Vector(0,0,0))
			caster:OnPhysicsFrame(nil)
			caster:PreventDI(false)
			caster:SetNavCollisionType(PHYSICS_NAV_SLIDE)
			caster:SetAutoUnstuck(true)
			caster:FollowNavMesh(true)
			caster:SetPhysicsFriction(.05)
			return nil
		end

		return 0.03
	end)
end