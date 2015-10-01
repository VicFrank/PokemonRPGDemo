--PP 30
--Power --
--Accuracy --
--Type PSYCHIC
--Category Status
--increases speed by 2 stages
function Agility( keys )
	local caster = keys.caster
	local pokemon = caster.pokemon
	local ability = keys.ability
	local debuff = ability:GetLevelSpecialValueFor("debuff", (ability:GetLevel() - 1))
	
	pokemon:IncrementSpeedBuffLevel( debuff )
end