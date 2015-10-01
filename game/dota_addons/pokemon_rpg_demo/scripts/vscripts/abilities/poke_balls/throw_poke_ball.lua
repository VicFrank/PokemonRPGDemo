function BeginCapture( keys )
	local caster = keys.caster
	local target = keys.target
	local model = keys.model
	local targetPokemon = target.pokemon	

	if targetPokemon == nil then
		print("Poke Balls only work on Pokemon!")
		EndCapture( keys )
	elseif not targetPokemon:IsWild() then
		print("You can only capture wild pokemon!")
		EndCapture( keys )
	else
		--put the pokemon in its ball
		if target.target_model == nil then
			target.target_model = target:GetModelName()
		end
		target:SetOriginalModel(model)
		--try and catch the pokemon
		--catch rate after accounting for the type of ball
		local modifiedCatchRate = targetPokemon:GetCatchRate()
		local statusBonus = 1
		--a is the modified catch rate
		local a = (( 3*  targetPokemon:GetMaxHP() - 2 * targetPokemon:GetCurrentHP() ) * modifiedCatchRate * statusBonus ) / ( 3 * targetPokemon:GetMaxHP() )
		--b is the probability that a single shake check passes
		local b = 1048560 / math.sqrt(math.sqrt(16711680/a)) --game freak pls
		if a > 255 then
			--automatically catch the pokemon
			Capture( keys )
		else
			--shake test, four checks, if a check fails, the pokemon is released, otherwise it is caught
			local i = 0
			Timers:CreateTimer(1,
				function()
					i = i + 1
					if i < 5 then
						if RandomInt(0,65535) >= b then
							--fail
							Notifications:RPGTextBox(0, {text="The Pokemon broke free!", duration=2, buttons=false, code=200, dialogueTree=""})
							target:RemoveModifierByName("in_pokeball")
							return
						else
							--succeed (shake)
							target:AddSpeechBubble(1, tostring(i), 1, 0, 0)
							return 1
						end
					else
						--we caught the pokemon!
						Notifications:RPGTextBox(0, {text=targetPokemon:GetName() .. " was caught!", duration=2, buttons=false, code=200, dialogueTree=""})
						Notifications:RPGTextBox(0, {text="Give " .. targetPokemon:GetName() .. " a nickname?", duration=2, buttons=true, code=200, dialogueTree=""})
						
						local item = CreateItem("item_poke_ball", caster, caster)
						targetPokemon:SetIsWild( false )
						item.pokemon = targetPokemon
						CreateItemOnPositionSync(target:GetAbsOrigin(), item)
						target:ForceKill( false )
					end
					
				end)
		end
	end
end

function EndCapture( keys )
	local target = keys.target

	-- Checking for errors
	if target.target_model ~= nil then
		target:SetModel(target.target_model)
		target:SetOriginalModel(target.target_model)
	end
end

--the next two functions don't work in this gamemode, screw hats anyway
--TODO ask Noya about this
--[[Author: Noya
	Date: 10.01.2015.
	Hides all dem hats
]]
function HideWearables( event )
	local hero = event.target

	local ability = event.ability
	local duration = ability:GetLevelSpecialValueFor( "duration", ability:GetLevel() - 1 )
	print("Hiding Wearables")
	--hero:AddNoDraw() -- Doesn't work on classname dota_item_wearable

	hero.wearableNames = {} -- In here we'll store the wearable names to revert the change
	hero.hiddenWearables = {} -- Keep every wearable handle in a table, as its way better to iterate than in the MovePeer system

	-- Handle faulty models (might be more!)
	if hero:GetModelName() == "models/heroes/lina/lina.vmdl" then
		print("lina.vmdl is potato")
		DeepPrintTable(hero:GetChildren())
		return
	end

    local model = hero:FirstMoveChild()
    while model ~= nil do
        if model:GetClassname() ~= "" and model:GetClassname() == "dota_item_wearable" then
            local modelName = model:GetModelName()
            if string.find(modelName, "invisiblebox") == nil then
            	-- Add the original model name to revert later
            	table.insert(hero.wearableNames,modelName)
            	print("Hidden "..modelName.."")

            	-- Set model invisible
            	model:SetModel("models/development/invisiblebox.vmdl")
            	table.insert(hero.hiddenWearables,model)
            end
        end
        model = model:NextMovePeer()
        if model ~= nil then
        	print("Next Peer:" .. model:GetModelName())
        end
    end
end

--[[Author: Noya
	Date: 10.01.2015.
	Shows the hidden hero wearables
]]
function ShowWearables( event )
	local hero = event.target
	print("Showing Wearables on ".. hero:GetModelName())

	if hero.hiddenWearables then
		-- Iterate on both tables to set each item back to their original modelName
		for i,v in ipairs(hero.hiddenWearables) do
			for index,modelName in ipairs(hero.wearableNames) do
				if i==index then
					print("Changed "..v:GetModelName().. " back to "..modelName)
					v:SetModel(modelName)
				end
			end
		end
	end
end