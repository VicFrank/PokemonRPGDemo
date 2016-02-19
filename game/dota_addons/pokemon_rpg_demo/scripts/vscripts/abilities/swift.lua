--PP 20
--Power 60
--Accuracy --
--Type NORMAL
--Category Special (magical)
function Swift( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local pokemon = target.pokemon

	if pokemon ~= nil then
		PokeHelper:CalculatePokemonDamage(ability, caster, target, "NORMAL")
	end
end