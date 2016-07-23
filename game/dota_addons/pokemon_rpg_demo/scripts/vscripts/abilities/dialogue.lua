function Talk( keys )
	local caster = keys.caster
	local playerID = caster.playerID
	local dialogueTable = caster.dialogueTable
	local range = 600
	local foundPlayer = false
	local trainerTable = FindUnitsInRadius(DOTA_TEAM_NEUTRALS, caster:GetAbsOrigin(), nil, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, 0, 0, false)

	for _,trainer in pairs(trainerTable) do
	    if trainer:GetPlayerID() == playerID then
	    	foundPlayer = true

	    	if trainer.state == "Normal" then
	    		trainer.state = "Talking"

	    		caster:SetForwardVector((trainer:GetAbsOrigin() - caster:GetAbsOrigin()):Normalized())

	    		trainer:AddNewModifier(trainer,nil,"modifier_rooted",{})
				trainer:AddNewModifier(trainer,nil,"modifier_invulnerable",{})

		    	for i=1,#(dialogueTable) do
					Notifications:RPGTextBox(playerID, {text=dialogueTable[i], duration=2, buttons=false, code=0, dialogueTree=""})
				end

				Timers:CreateTimer(2*(#dialogueTable), function()
					trainer:RemoveModifierByName("modifier_rooted")
					trainer:RemoveModifierByName("modifier_invulnerable")
					trainer.state = "Normal"
				end)
			end
		end
	end

	if not foundPlayer then
		Notifications:DisplayError(playerID, "#dota_hud_error_target_out_of_range")
	end
end