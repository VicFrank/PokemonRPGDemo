--PP 15
--Power 80
--Accuracy 100%
--Type DARK
--Category Physical (physical)
--20% chance to lower defense by one stage
function Crunch( keys )
	local caster = keys.caster
	local target = keys.target
	local target_location = target:GetAbsOrigin()
	local ability = keys.ability
	local debuffChance = ability:GetLevelSpecialValueFor("debuffChance", (ability:GetLevel() - 1))
	local debuff = ability:GetLevelSpecialValueFor("debuff", (ability:GetLevel() - 1))
	local pokemon = target.pokemon

	if pokemon ~= nil then
		PokeHelper:CalculatePokemonDamage(ability, caster, target, "DARK")
		if RandomFloat(0,100) < debuffChance then
			pokemon:IncrementDefenseBuffLevel( debuff )
		end
	end
end