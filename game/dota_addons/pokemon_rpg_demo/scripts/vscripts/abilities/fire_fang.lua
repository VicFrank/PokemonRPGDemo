--PP 15
--Power 65
--Accuracy 95%
--Type FIRE
--Category Physical (physical)
--10% chance to burn
--10% chance to flinch
function FireFang( keys )
	local caster = keys.caster
	local target = keys.target
	local target_location = target:GetAbsOrigin()
	local ability = keys.ability
	local flinchChance = ability:GetLevelSpecialValueFor("flinch_chance", (ability:GetLevel() - 1))
	local burnChance = ability:GetLevelSpecialValueFor("burn_chance", (ability:GetLevel() - 1))
	local pokemon = target.pokemon

	if pokemon ~= nil then
		PokeHelper:CalculatePokemonDamage(ability, caster, target, "FIRE")
		if RandomFloat(0,1) < flinchChance then
			ability:ApplyDataDrivenModifier(caster, target, "flinch", {})
		end
		if RandomFloat(0,1) < burnChance then
			PokeHelper:InflictStatus( target, "BURNED" )
		end
	end
end