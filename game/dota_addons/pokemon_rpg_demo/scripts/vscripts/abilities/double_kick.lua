--PP 30
--Power 30
--Accuracy 100%
--Type FIGHTING
--Category Physical
--hits twice
function DoubleKick( keys )
	local caster = keys.caster
	local ability = keys.ability
	local damage_radius = ability:GetLevelSpecialValueFor("damage_radius", (ability:GetLevel() - 1))
	local direction = caster:GetForwardVector()
	local center = caster:GetAbsOrigin() + direction * damage_radius

	caster:Stop()
	caster:StartGesture(ACT_DOTA_ATTACK)
	
	--first kick
	Timers:CreateTimer(.5, function()
		local searchArea = FindUnitsInRadius( caster:GetTeam(), center, nil, damage_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, 0, false )
		for _,v in pairs(searchArea) do
			EmitSoundOn("Hero_Centaur.HoofStomp", v)
			PokeHelper:CalculatePokemonDamage(ability, caster, v, "FIGHTING")
		end
		--second kick
		caster:Stop()
		caster:StartGesture(ACT_DOTA_ATTACK)
		Timers:CreateTimer(.3, function()
			local searchArea = FindUnitsInRadius( caster:GetTeam(), center, nil, damage_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, 0, false )
			for _,v in pairs(searchArea) do
				EmitSoundOn("Hero_Centaur.HoofStomp", v)
				PokeHelper:CalculatePokemonDamage(ability, caster, v, "FIGHTING")
			end
		end)
	end)
end