--PP 5
--Power --
--Accuracy --%
--Type GRASS
--Category status
--restores half the user's max HP
--at morning and in the night, clear conditions restore ¼, sunny conditions restore ½ and other conditions restore ⅛ HP. At the daytime, the move restores twice as much of HP.
function Synthesis( keys )
	local caster = keys.caster
	local ability = keys.ability
	local pokemon = caster.pokemon
	local duration = ability:GetLevelSpecialValueFor("duration", (ability:GetLevel() - 1))
	local tickInterval = .3
	local heal = (pokemon:GetMaxHP() / 2) * (tickInterval / duration)

	if pokemon ~= nil then
		Timers:CreateTimer(0,
			function()
				if caster:IsAlive() and caster:FindModifierByName("modifier_synthesis") ~= nil then
					caster:Heal(heal,caster)
					pokemon:SetCurrentHP(caster:GetHealth())
					return tickInterval
				else
					return
				end
			end)
	end
end