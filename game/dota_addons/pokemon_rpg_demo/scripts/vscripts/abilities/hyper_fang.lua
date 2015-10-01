--PP 15
--Power 80
--Accuracy 90%
--Type NORMAL
--Category Physical (physical)
--10% chance to flinch
function HyperFang( keys )
	local caster = keys.caster
	local target = keys.target
	local target_location = target:GetAbsOrigin()
	local ability = keys.ability
	local flinchChance = ability:GetLevelSpecialValueFor("flinch_chance", (ability:GetLevel() - 1))
	local pokemon = target.pokemon

	if pokemon ~= nil then
		PokeHelper:CalculatePokemonDamage(ability, caster, target, "NORMAL")
		if RandomFloat(0,1) < flinchChance then
			ability:ApplyDataDrivenModifier(caster, target, "flinch", {})
		end
	end
end