--PP 25
--Power 45
--Accuracy 100%
--Type GRASS
--Category Physical
function VineWhip( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local pokemon = target.pokemon

	if pokemon ~= nil then
		PokeHelper:CalculatePokemonDamage(ability, caster, target, "GRASS")
	end
end