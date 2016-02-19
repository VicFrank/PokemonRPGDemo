--PP 30
--Power 40
--Accuracy 100%
--Type WATER
--Category Special (magical)
--10% chance to lower speed by 1
function Bubble( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local debuff = ability:GetLevelSpecialValueFor("debuff", (ability:GetLevel() - 1))
	local debuffChance = ability:GetLevelSpecialValueFor("debuff_chance", (ability:GetLevel() - 1))
	local pokemon = target.pokemon

	if pokemon ~= nil then
		PokeHelper:CalculatePokemonDamage(ability, caster, target, "WATER")
		if RandomFloat(0,100) < debuffChance then
			pokemon:IncrementSpeedBuffLevel( debuff )
		end
	end
end