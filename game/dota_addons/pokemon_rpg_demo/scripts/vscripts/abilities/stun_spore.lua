--PP 30
--Power --
--Accuracy 75%
--Type GRASS
--Category Status
--paralyzes the target
function StunSpore( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local pokemon = target.pokemon

	if pokemon ~= nil then
		PokeHelper:InflictStatus( target, "PARALYZED" )
	end
end