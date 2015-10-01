--PP 40
--Power --
--Accuracy --
--Type WATER
--Category Status
--increases defense by 1
function Withdraw( keys )
	local caster = keys.caster
	local pokemon = caster.pokemon
	local ability = keys.ability
	local debuff = ability:GetLevelSpecialValueFor("debuff", (ability:GetLevel() - 1))
	
	pokemon:IncrementDefenseBuffLevel( debuff )
end