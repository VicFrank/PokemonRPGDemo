--PP 15
--Power 65
--Accuracy 95%
--Type ICE
--Category Physical (physical)
--10% chance to freeze
--10% chance to flinch
function IceFang( keys )
	local caster = keys.caster
	local target = keys.target
	local target_location = target:GetAbsOrigin()
	local ability = keys.ability
	local flinchChance = ability:GetLevelSpecialValueFor("flinch_chance", (ability:GetLevel() - 1))
	local freezeChance = ability:GetLevelSpecialValueFor("freeze_chance", (ability:GetLevel() - 1))
	local pokemon = target.pokemon

	if pokemon ~= nil then
		PokeHelper:CalculatePokemonDamage(ability, caster, target, "ICE")
		if RandomFloat(0,1) < flinchChance then
			ability:ApplyDataDrivenModifier(caster, target, "flinch", {})
		end
		if RandomFloat(0,1) < freezeChance then
			pokemon:InflictStatus( "FROZEN" )
		end
	end
end