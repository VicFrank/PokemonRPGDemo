--PP 25
--Power 55
--Accuracy 95%
--Type GRASS
--Category Physical
--high critical hit ratio
function RazorLeaf( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local pokemon = target.pokemon

	if pokemon ~= nil then
		PokeHelper:CalculatePokemonDamage(ability, caster, target, "GRASS")
	end
end