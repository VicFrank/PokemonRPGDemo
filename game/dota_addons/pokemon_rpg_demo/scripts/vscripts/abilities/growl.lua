--PP 40
--Power --
--Accuracy 100%
--Type NORMAL
--Category Status
--decreases target's attack by 1
function Growl( keys )
	local target = keys.target
	local ability = keys.ability
	local debuff = ability:GetLevelSpecialValueFor("debuff", (ability:GetLevel() - 1))
	local pokemon = target.pokemon
	
	if pokemon ~= nil then
		--doesn't affect ghosts
		if pokemon:GetType1() ~= "GHOST" and pokemon:GetType2() ~= "GHOST" then
			pokemon:IncrementAttackBuffLevel( debuff )
		end
	end
end