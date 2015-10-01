--PP 35
--Power 40
--Accuracy 100%
--Type FLYING
--Category Special (magical)
function Gust( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local pokemon = target.pokemon

	if pokemon ~= nil then
		PokeHelper:CalculatePokemonDamage(ability, caster, target, "FLYING")
	end
end