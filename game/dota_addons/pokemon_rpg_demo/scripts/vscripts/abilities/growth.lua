--PP 20
--Power --
--Accuracy --%
--Type NORMAL
--Category Status
--increases attack and special attack by 1
function GrowthStart( keys )
	local caster = keys.caster
	local ability = keys.ability
	
	caster:SetModelScale(caster:GetModelScale() * 1.5)
end

function GrowthEnd( keys )
	local caster = keys.caster
	local pokemon = caster.pokemon
	local ability = keys.ability
	local debuff = ability:GetLevelSpecialValueFor("debuff", (ability:GetLevel() - 1))
	
	caster:SetModelScale(caster:GetModelScale() / 1.5)
	
	pokemon:IncrementAttackBuffLevel( debuff )
	pokemon:IncrementSpecialAttackBuffLevel( debuff )
end