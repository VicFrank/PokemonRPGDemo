--PP 15
--Power --
--Accuracy --
--Type STEEL
--Category Status
--increases defense by 2
function IronDefense( keys )
	local caster = keys.caster
	local pokemon = caster.pokemon
	local ability = keys.ability
	local debuff = ability:GetLevelSpecialValueFor("debuff", (ability:GetLevel() - 1))
	
	pokemon:IncrementDefenseBuffLevel( debuff )
end