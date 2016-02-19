--PP 20
--Power 60
--Accuracy 100%
--Type WATER
--Category Special (magical)
--20% chance to confuse
function WaterPulse( keys )
	local caster = keys.caster
	local target = keys.target
	local target_location = target:GetAbsOrigin()
	local ability = keys.ability
	local debuffChance = ability:GetLevelSpecialValueFor("debuff_chance", (ability:GetLevel() - 1))
	local pokemon = target.pokemon

	if pokemon ~= nil then
		PokeHelper:CalculatePokemonDamage(ability, caster, target, "WATER")
		if RandomFloat(0,100) < debuffChance then
			--apply confusion modifier
			print(pokemon:GetName() .. " is confused!")
		end
	end
end