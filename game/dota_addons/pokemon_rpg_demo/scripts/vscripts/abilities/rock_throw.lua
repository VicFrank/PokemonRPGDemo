--PP 15
--Power 50
--Accuracy 90%
--Type ROCK
--Category Physical 
function RockThrow( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local pokemon = target.pokemon

	if pokemon ~= nil then
		PokeHelper:CalculatePokemonDamage(ability, caster, target, "ROCK")
	end
end