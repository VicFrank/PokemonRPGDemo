--PP 15
--Power 18
--Accuracy 80%
--Type NORMAL
--Category Physical
--hits the target 2-5 times
function FurySwipes( keys )
	keys.swipeCount = 0
	keys.numberOfSwipes = 0
	
	local roll = RandomFloat(0,1)
	--There is a 37.5% chance that it will hit 2 times, a 37.5% chance that it will hit 3 times, a 12.5% chance that it will hit 4 times, and a 12.5% chance that it will hit 5 times. 
	if roll < .375 then
		keys.numberOfSwipes = 2
	elseif roll >= .375 and roll < .75 then
		keys.numberOfSwipes = 3
	elseif roll >= .75 and roll < .875 then
		keys.numberOfSwipes = 4
	elseif roll >= .875 then
		keys.numberOfSwipes = 5
	end
	
	Swipe( keys )
end

function Swipe( keys )
	local caster = keys.caster
	local ability = keys.ability
	local damage_radius = ability:GetLevelSpecialValueFor("damage_radius", (ability:GetLevel() - 1))
	local direction = caster:GetForwardVector()
	local center = caster:GetAbsOrigin() + direction * damage_radius

	keys.swipeCount = keys.swipeCount + 1
	
	if keys.swipeCount > keys.numberOfSwipes then
		return
	end
	
	caster:Stop()
	caster:StartGesture(ACT_DOTA_ATTACK)
	
	Timers:CreateTimer(.35, function()
		local searchArea = FindUnitsInRadius( caster:GetTeam(), center, nil, damage_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, 0, false )
		for _,v in pairs(searchArea) do
			EmitSoundOn("Hero_Ursa.Attack", v)
			PokeHelper:CalculatePokemonDamage(ability, caster, v, "NORMAL")
		end
		Swipe( keys )
	end)
end