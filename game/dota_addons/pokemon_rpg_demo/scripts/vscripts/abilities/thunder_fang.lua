--PP 15
--Power 65
--Accuracy 95%
--Type ELECTRIC
--Category Physical (physical)
--10% chance to paralyze
--10% chance to flinch
function ThunderFang( keys )
	local caster = keys.caster
	local target = keys.target
	local target_location = target:GetAbsOrigin()
	local ability = keys.ability
	local flinchChance = ability:GetLevelSpecialValueFor("flinch_chance", (ability:GetLevel() - 1))
	local paralyzeChance = ability:GetLevelSpecialValueFor("paralyze_chance", (ability:GetLevel() - 1))
	local pokemon = target.pokemon

	if pokemon ~= nil then
		PokeHelper:CalculatePokemonDamage(ability, caster, target, "ELECTRIC")
		if RandomFloat(0,1) < flinchChance then
			ability:ApplyDataDrivenModifier(caster, target, "flinch", {})
		end
		if RandomFloat(0,1) < paralyzeChance then
			PokeHelper:InflictStatus( target, "PARALYZED" )
		end
	end
end