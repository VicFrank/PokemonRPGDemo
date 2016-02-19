--PP 35
--Power 15
--Accuracy 100%
--Type POISON
--Category Physical
--30% chance to poison
function PoisonSting( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local debuffChance = ability:GetLevelSpecialValueFor("debuff_chance", (ability:GetLevel() - 1))
	local pokemon = target.pokemon

	if pokemon ~= nil then
		PokeHelper:CalculatePokemonDamage(ability, caster, target, "POISON")
		if RandomFloat(0,100) < debuffChance then
			PokeHelper:InflictStatus( target, "POISONED" )
		end
	end
end