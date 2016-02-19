--PP 20
--Power 25
--Accuracy 100%
--Type POISON
--Category Physical
--20% chance to poison, fires two projectiles
function Twineedle( keys )
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