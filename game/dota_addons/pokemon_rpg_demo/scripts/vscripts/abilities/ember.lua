--PP 25
--Power 40
--Accuracy 100%
--Type FIRE
--Category Special
--10% chance to burn
function Ember( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local debuffChance = ability:GetLevelSpecialValueFor("debuff_chance", (ability:GetLevel() - 1))
	local pokemon = target.pokemon
	

	if pokemon ~= nil then
		PokeHelper:CalculatePokemonDamage(ability, caster, target, "FIRE")
		if RandomFloat(0,100) < debuffChance then
			PokeHelper:InflictStatus( target, "BURNED" )
		end
	end
end