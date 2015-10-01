--PP 10
--Power --
--Accuracy 100%
--Type DRAGON
--Category Special (PURE in this case)
--Always deals 40 damage if it hits
function DragonRage( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local pokemon = target.pokemon

	if pokemon ~= nil then
		PokeHelper:CalculatePokemonDamage(ability, caster, target, "DRAGON")
	end
end