--PP 15
--Power 75
--Accuracy 95%
--Type NORMAL
--Category Special
--30% chance to flinch
function Slash( keys )
	local caster = keys.caster
	local ability = keys.ability
	local damage_radius = ability:GetLevelSpecialValueFor("damage_radius", (ability:GetLevel() - 1))
	local flinchChance = ability:GetLevelSpecialValueFor("flinch_chance", (ability:GetLevel() - 1))
	local direction = caster:GetForwardVector()
	local center = caster:GetAbsOrigin() + direction * damage_radius

	caster:Stop()
	caster:StartGesture(ACT_DOTA_ATTACK)
	
	Timers:CreateTimer(.5, function()
		local searchArea = FindUnitsInRadius( caster:GetTeam(), center, nil, damage_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, 0, false )
		for _,v in pairs(searchArea) do
			EmitSoundOn("Hero_NyxAssassin.attack", v)
			PokeHelper:CalculatePokemonDamage(ability, caster, v, "NORMAL")
			if RandomFloat(0,1) < flinchChance then
				ability:ApplyDataDrivenModifier(caster, v, "flinch", {})
			end
		end
	end)
end