--PP 25
--Power 60
--Accuracy 100%
--Type DARK
--Category Physical (physical)
--30% chance to flinch
function Bite( keys )
	local caster = keys.caster
	local target = keys.target
	local target_location = target:GetAbsOrigin()
	local ability = keys.ability
	local flinchChance = ability:GetLevelSpecialValueFor("flinch_chance", (ability:GetLevel() - 1))
	local pokemon = target.pokemon

	if pokemon ~= nil then
		PokeHelper:CalculatePokemonDamage(ability, caster, target, "DARK")
		if RandomFloat(0,1) < flinchChance then
			ability:ApplyDataDrivenModifier(caster, target, "flinch", {})
		end
	end
end