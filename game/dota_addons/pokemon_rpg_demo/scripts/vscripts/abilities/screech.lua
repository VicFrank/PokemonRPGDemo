--PP 40
--Power --
--Accuracy 85%
--Type NORMAL
--Category Status
--decreases target's defense by 2
function Screech( keys )
	local target = keys.target
	local ability = keys.ability
	local debuff = ability:GetLevelSpecialValueFor("debuff", (ability:GetLevel() - 1))
	local pokemon = target.pokemon
	
	if pokemon ~= nil then
		--doesn't affect ghosts
		if pokemon:GetType1() ~= "GHOST" and pokemon:GetType2() ~= "GHOST" then
			pokemon:IncrementDefenseBuffLevel( debuff )
		end
	end
end