--PP 35
--Power --
--Accuracy 75%
--Type POISON
--Category Status
--poisons the target
function PoisonPowder( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local pokemon = target.pokemon

	if pokemon ~= nil then
		PokeHelper:InflictStatus( target, "POISONED" )
	end
end