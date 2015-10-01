--PP 30
--Power --
--Accuracy --
--Type NORMAL
--Category Status
--increases defense by 1
function Harden( keys )
	local caster = keys.caster
	local pokemon = caster.pokemon
	local ability = keys.ability
	local debuff = ability:GetLevelSpecialValueFor("debuff", (ability:GetLevel() - 1))
	
	pokemon:IncrementDefenseBuffLevel( debuff )
end