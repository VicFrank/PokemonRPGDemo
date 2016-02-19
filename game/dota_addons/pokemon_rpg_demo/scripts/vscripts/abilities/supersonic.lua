--PP 20
--Power --
--Accuracy 55%
--Type NORMAL
--Category Status
--Causes target to become confused
function Supersonic( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local pokemon = target.pokemon

	if pokemon ~= nil then
		PokeHelper:ApplyModifier( target, "modifier_confusion" )
	end
end