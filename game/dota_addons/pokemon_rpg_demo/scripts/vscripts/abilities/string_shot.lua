--PP 40
--Power --
--Accuracy 95%
--Type BUG
--Category Status
--Lowers speed by 1
function StringShot( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local debuff = ability:GetLevelSpecialValueFor("debuff", (ability:GetLevel() - 1))
	local pokemon = target.pokemon

	if pokemon ~= nil then
		pokemon:IncrementSpeedBuffLevel( debuff )
	end
end