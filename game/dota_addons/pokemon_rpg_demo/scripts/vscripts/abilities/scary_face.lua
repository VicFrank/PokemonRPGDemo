--PP 10
--Power --
--Accuracy 100
--Type NORMAL
--Category Status
--lowers target's speed by two stages
--based on stone gaze from the spell library
function ScaryFaceStart( keys )
	local caster = keys.caster

	caster.scary_face_table = {}
end

function ScaryFace( keys )
	local caster = keys.caster
	local target = keys.target
	local pokemon = caster.pokemon
	local ability = keys.ability
	local debuff = ability:GetLevelSpecialValueFor("debuff", (ability:GetLevel() - 1))
	local vision_cone = ability:GetLevelSpecialValueFor("vision_cone", (ability:GetLevel() - 1))
	
	if pokemon ~= nil then
			local check = false
			-- Check if its a target from before
			for _,v in ipairs(caster.scary_face_table) do
				if v == target then
					check = true
				end
			end

			if not check then
				-- If its a new target then add it to the table
				print("scary face")
				table.insert(caster.scary_face_table, target)
				-- Apply the debuff
				pokemon:IncrementSpeedBuffLevel( debuff )
			end
	end
end