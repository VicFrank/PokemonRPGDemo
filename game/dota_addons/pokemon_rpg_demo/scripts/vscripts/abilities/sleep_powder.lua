--PP 15
--Power --
--Accuracy 75%
--Type GRASS
--Category Status
--puts the target to sleep
function SleepPowder( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local pokemon = target.pokemon

	if pokemon ~= nil then
		PokeHelper:InflictStatus( target, "SLEEP" )
	end
end