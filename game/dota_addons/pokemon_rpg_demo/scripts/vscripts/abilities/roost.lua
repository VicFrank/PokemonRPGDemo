--PP 10
--Power --
--Accuracy --%
--Type FLYING
--Category status
--restores half the user's max HP
function RoostStart( keys )
	local caster = keys.caster
	local ability = keys.ability
	local pokemon = caster.pokemon
	local duration = ability:GetLevelSpecialValueFor("duration", (ability:GetLevel() - 1))
	local tickInterval = .3
	local heal = (pokemon:GetMaxHP() / 2) * (tickInterval / duration)

	if pokemon ~= nil then
		Timers:CreateTimer(0,
			function()
				if caster:IsAlive() and caster:FindModifierByName("roosting") ~= nil then
					caster:Heal(heal,caster)
					pokemon:SetCurrentHP(caster:GetHealth())
					return tickInterval
				else
					print("Ending Roost.")
					return
				end
			end)
	end
end